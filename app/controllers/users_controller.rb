# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show update destroy]

  def create
    user = User.new(user_params)
    authorize user

    if params[:user][:profile_picture]
      user.profile_picture.attach(params[:user][:profile_picture])
    end

    if user.save
      render json: { user: user, message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    organization_id = current_user.organization_id
    presenter = UserListPresenter.new(organization_id)
    render json: presenter.data
  end

  def show
    authorize @user
    render json: @user
  end

  def update
    authorize @user

    if params[:user][:profile_picture]
      @user.profile_picture.attach(params[:user][:profile_picture])
    end

    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    permitted = %i[email first_name last_name dob doj password employee_id profile_picture]
    permitted << :role << :organization_id if current_user.admin?
    params.require(:user).permit(permitted)
  end
end