require_relative './../modules/authorization_module'
class Api::EstadisticasController < ApplicationController
  include AuthorizationModule

  before_action :set_estadistica, only: [:show, :update, :destroy]
  before_action :authenticate_api_user!, only:[:index, :show, :destroy]
 before_action :authorize_user, only:[:create]

  # GET /estadisticas
  def index
    @estadisticas = Estadistica.all

    render json: @estadisticas.to_json()
  end

  # GET /estadisticas/1
  def show
    render json: @estadistica.to_json
  end

  # POST /estadisticas
  def create
    @estadistica = Estadistica.new(estadistica_params)

    @estadistica.user = current_api_user        
    
    puts estadistica_params
    

    if @estadistica.save
      render json: @estadistica, status: :created
    else
      render json: @estadistica.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /estadisticas/1
  def update
    if @estadistica.update(estadistica_params)
      render json: @estadistica
    else
      render json: @estadistica.errors, status: :unprocessable_entity
    end
  end

  # DELETE /estadisticas/1
  def destroy
    @estadistica.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estadistica
      @estadistica = Estadistica.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def estadistica_params
      params.require(:estadistica).permit(:user_id, :add_linkedin_count, :list_visits_count, :web_views_count, :share_linkedin, :list_name)
    end
end
