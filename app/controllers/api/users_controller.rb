class Api::UsersController < ApplicationController

  before_action :set_user, only: [:show]

  before_action :authenticate_api_user!, only:[:show]

  def index
    render json: current_api_user
  end

  def show
    @user = current_api_user
    render json: @user
  end

  def verifydni
    @person = User.find_by(dni: params[:dni])
    if @person == nil
      render json: {errors: "no credentials"}
    else
      @credentials = @person.credentials
      render json: {user: @person, credentials: @credentials}
    end
    
  end
  # private
  # def set_user
  #   @user = User.find(params[:id])
  # end
end