class ApplicationController < ActionController::API
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # Decode the JWT token
  def current_user
    decoded_token = decode_token
    if decoded_token
      user_id = decoded_token[0]["user_id"]
      @current_user ||= User.find(user_id)
    end
  end

  # Protect endpoints with this method
  def authenticate_user!
    render json: { error: 'Not Authorized' }, status: :unauthorized unless current_user
  end

  private

  def user_not_authorized
    render json: { error: "You are not authorized to perform this action" }, status: :forbidden
  end

  # Decode JWT Token
  def decode_token
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      begin
        JWT.decode(token, Rails.application.secret_key_base, true, { algorithm: 'HS256' })
      rescue JWT::DecodeError => e
        nil
      end
    end
  end
end
