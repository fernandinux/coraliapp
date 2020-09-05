module Overrides
  class TokenValidationsController < DeviseTokenAuth::TokenValidationsController

    def validate_token
      if @resource
        data = @resource.as_json
        data['image'] = @resource.get_user_image_url
        render json: {
          data: data
        }
      else
        render json: {
          success: false,
          errors: ["Invalid login credentials"]
        }, status: 401
      end
    end
  end
end