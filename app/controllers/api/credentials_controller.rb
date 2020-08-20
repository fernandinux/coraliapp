class Api::CredentialsController < ApplicationController
    before_action :set_credential, only:[:show, :destroy]

    before_action :authenticate_api_user!

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
end