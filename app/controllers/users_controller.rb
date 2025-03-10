class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :update]

  def index
    @users = current_user.organization.users
    render json: @users
  end

  def show
    @user = current_user.organization.users.find(params[:id])
    render json: @user
  end

  def update
    @user = current_user.organization.users.find(params[:id])
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :role)
  end
end
