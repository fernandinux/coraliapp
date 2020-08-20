class Api::CredentialsController < ApplicationController
    before_action :set_credential, only:[:show]

    def index
      # if(params[:user_id])
        @user = User.find(params[:user_id])
        @credentials = @user.credentials
      # end
      render json:@credentials
    end

    def show
      render json: @credential
    end


    private
    def set_credential
      @user = User.find(params[:user_id])
      @credential = @user.credentials.find(params[:id])
    end
end