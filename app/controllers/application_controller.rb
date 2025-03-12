# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit
  before_action :set_current_organization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # Decode the JWT token
  def current_user
    decoded_token = decode_token
    return unless decoded_token

    user_id = decoded_token[0]['user_id']
    @current_user ||= User.find_by(id: user_id)
  end

  # Protect endpoints with this method
  def authenticate_user!
    render json: { error: 'Not Authorized' }, status: :unauthorized unless current_user
  end

  private

  def user_not_authorized
    render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
  end

  # Decode JWT Token
  def decode_token
    return unless request.headers['Authorization'].present?

    token = request.headers['Authorization'].split(' ').last
    begin
      JWT.decode(token, Rails.application.secret_key_base, true, { algorithm: 'HS256' })
    rescue JWT::DecodeError
      nil
    end
  end

  def set_current_organization
    Current.organization_id = current_user.organization_id if current_user
  end
end
