require 'csv'
require 'securerandom'
require_relative './../modules/authorization_module'

TYPE_CREDENTIALS = {
  proof: 0,
  certificate: 1
}

class Api::CredentialsController < ApplicationController
    include AuthorizationModule

    before_action :set_credential, only:[:show, :destroy]
    before_action :authenticate_api_user!, only:[:index, :show, :destroy]
    before_action :authorize_user, only:[:create]

    def create_by_multiple_raw_files
      keys_receievd = params.keys()

      if !keys_receievd.include? "users"
        return render json: {errors: "no users attached"}
      elsif !keys_receievd.include? "credentials"
        return render json: {errors: "no credentials attached"}
      elsif !keys_receievd.include? "list_name"
        return render json: {errors: "no list_name provided"}
      elsif !keys_receievd.include? "event_name"
        return render json: {errors: "no event_name provided"}
      end

      users = CSV.read(params[:users], "r:ISO-8859-1")
      credentials = params[:credentials]
      list_name = params[:list_name]
      event_name = params[:event_name]
      headers_users_csv = users.shift
      name_index = headers_users_csv.find_index("nombres")
      lastname_index = headers_users_csv.find_index("apellidos")
      dni_index = headers_users_csv.find_index("dni")
      email_index = headers_users_csv.find_index("email")
      phone_index = headers_users_csv.find_index("telefono")
      linkedin_index = headers_users_csv.find_index("linkedin")

      unless (name_index and lastname_index and dni_index and email_index and phone_index and linkedin_index)
        return render json: {errors: "the file with users must have the headers: nombres, apellidos, dni, email, telefono, linkedin"}
      end

      unless (users.size == credentials.size)
        return render json: {errors: "you must attach the same number of users and credentials"}
      end

      new_credentials = []
      new_event = Event.new
      new_event.name = event_name
      new_list = List.new
      new_list.name = list_name
      new_list.event = new_event
      
      if new_event.valid? and new_list.valid?
        unless new_event.save
          return render json: {errors: new_event.errors.full_messages}
        end
        
        unless new_list.save
          return render json: {errors: new_list.errors.full_messages}
        end
      end

      users.each do |user|
        credential_assigned = credentials.find {|e| e.original_filename.start_with?(user[dni_index])}

        if !credential_assigned
          return render json: {errors: "names of images must match with the DNIs of users"}
        end

        temp_certificate = Credential.new(file: credential_assigned)
        temp_user = User.find_by(dni: user[dni_index])
        temp_certificate.type_credential = TYPE_CREDENTIALS[:certificate]
        temp_certificate.code = SecureRandom.uuid
        temp_certificate.dni_user = user[dni_index]
        temp_certificate.email_user = user[email_index]
        temp_certificate.name_institution = current_api_user.name
        temp_certificate.name_user = user[name_index]
        temp_certificate.lastname_user = user[lastname_index]
        temp_certificate.issue_at = Time.new
        temp_certificate.list = new_list
        temp_certificate.user = temp_user
        
        new_credentials << temp_certificate
      end

      Credential.import new_credentials
      
      new_credentials.each do |c|
        credential_assigned = credentials.find {|e| e.original_filename.start_with?(c.dni_user)}
        c.file.attach(credential_assigned)
        c.save
      end

      render json: new_credentials
    end

    def index
      @user = current_api_user
      if(@user.role == "user" )
        @credentials = @user.credentials
      else
        @credentials = Credential.all
      end

      if(@credentials.length == 0)
        render json: {errors: "no credentials"}
      else
        render json: @credentials
      end
    end

    def create
      @credential = Credential.new(credential_params)

      if current_api_user.isUser?
        @credential.user = current_api_user
        @credential.dni_user = current_api_user.dni
        @credential.email_user = current_api_user.email
      end

      puts credential_params

      if @credential.save
      render json: @credential, status: :created
      else
        render json: @credential.errors, status: :unprocessable_entity
      end
    end

    def show
      render json: @credential
    end

    def destroy
      @credential.destroy
    end

    def verifycode
      @credentialCode = Credential.find_by(code: params[:code])
      if @credentialCode == nil
        render json: {errors: "no credential"}
      else
        render json: {credential: @credentialCode, pdf: @credentialCode.get_credential_file_url}
      end
    end
    
    private

    def set_credential
      unless current_api_user
        render json: {user: "User not found"}, status: :unauthorized
      else
        @credential = current_api_user.credentials.find(params[:id])
      end
    end

    def credential_params
      params
      .permit(
        :title,
        :body, 
        :code,
        :type_credential, 
        :status, 
        :expiration_at, 
        :event,
        :dni_user,
        :email_user,
        :file,
        :name_institution,
        :name_course,
        :description,
        :issue_at
      )
    end
end