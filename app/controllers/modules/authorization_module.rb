module AuthorizationModule
  def authorize_user
    unless current_api_user.isUser?
      errors = { errors: { message: 'Access denied' } }
      render json: errors, status: :unauthorized
    end
  end

  def authorize_institution
    unless current_api_user.isInstitution?
      errors = { errors: { message: 'Access denied' } }
      render json: errors, status: :unauthorized
    end
  end
end