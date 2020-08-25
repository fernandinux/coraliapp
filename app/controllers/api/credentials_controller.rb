require_relative './../modules/authorization_module'

class Api::CredentialsController < ApplicationController
    include AuthorizationModule

    before_action :set_credential, only:[:show, :destroy]
    before_action :authenticate_api_user!
    before_action :authorize_user, only:[:create]

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
        :body, 
        :code,
        :type_credential, 
        :status, 
        :expiration_at, 
        :event,
        :dni_user,
        :email_user,
        :file,
      )
    end
end