# frozen_string_literal: true

class AuthenticationController < ApplicationController
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

  private

  # Encode JWT Token
  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
