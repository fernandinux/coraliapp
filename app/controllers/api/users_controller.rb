class Api::UsersController < ApplicationController

  before_action :set_user, only: [:update]

  before_action :authenticate_api_user!, only:[:show]

  def index
    render json: current_api_user
  end

  def show
    @user = current_api_user
    render json: @user
  end

  def update
    p user_params
    p"------------------------"
    if @current.update(user_params)
      render json: @current
    else
      render json: @current.errors, status: :unprocessable_entity
    end
  end

  def getImage
    @user = User.find(params[:id])
    render json: {image_url: @user.get_user_image_url}
  end
  def imageprofile
    @user = User.find(params[:id])
    @user.image.attach(params[:image])

    if(@user.save)
      render json: {image_url: @user.get_user_image_url}
    else
      render json: @user.errors, status: :unprocessable_entity
    end
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
  private

  def user_params
    params.require(:user).permit(:name, 
    :last_name, 
    :nickname,
    :dni,
    :image,
    :email,
    :role,
    :web,
    :description, 
    :phone,
    :linkedin
    )
  end
  def set_user
    @current = User.find(params[:id])
  end
end