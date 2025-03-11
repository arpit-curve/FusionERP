# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show update destroy]

  def create
    user = User.new(user_params)
    authorize user

    if user.save
      render json: { user: user, message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @users = policy_scope(User)
    render json: @users
  end

  def show
    authorize @user
    user = current_user.organization.users.find(params[:id])
    render json: user
  end

  def update
    authorize @user
    user = current_user.organization.users.find(params[:id])
    if user.update(user_params)
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    permitted = %i[email first_name last_name dob doj password employee_id]
    permitted << :role << :organization_id if current_user.admin?
    params.require(:user).permit(permitted)
  end
end
