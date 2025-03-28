# frozen_string_literal: true

class AuthenticationController < ApplicationController
  before_action :authorize_request, only: [:logout]

  # POST /login
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id, organization_id: user.organization.id })
      render json: { token: token, user: user }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  # POST /logout
  def logout
    token = request.headers['Authorization']&.split(' ')&.last

    if token
      BlacklistedToken.create(token: token)
      render json: { message: 'Logged out successfully' }, status: :ok
    else
      render json: { error: 'Token not provided' }, status: :unprocessable_entity
    end
  end

  private

  # Encode JWT Token
  def encode_token(payload)
    payload[:iat] = Time.now.to_i # Add issued-at timestamp
    payload[:jti] = SecureRandom.uuid # Add unique identifier
    JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
  end

  # # Decode JWT Token
  # def decode_token(token)
  #   JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')[0]
  # rescue JWT::DecodeError
  #   nil
  # end

  # Authorization Check
  def authorize_request
    token = request.headers['Authorization']&.split(' ')&.last
    return unless token.nil? || BlacklistedToken.exists?(token: token)

    render json: { error: 'Unauthorized or token blacklisted' }, status: :unauthorized
  end
end
