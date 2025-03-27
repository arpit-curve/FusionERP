# frozen_string_literal: true

class RolesController < ApplicationController
  before_action :set_role, only: %i[show update destroy]

  # GET /roles
  def index
    @roles = Role.all
    render json: @roles
  end

  # GET /roles/:id
  def show
    authorize @role
    render json: @role
  end

  # POST /roles
  def create
    @role = Role.new(role_params)
    authorize @role

    if @role.save
      render json: @role, status: :created
    else
      render json: @role.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /roles/:id
  def update
    authorize @role
    if @role.update(role_params)
      render json: @role
    else
      render json: @role.errors, status: :unprocessable_entity
    end
  end

  # DELETE /roles/:id
  def destroy
    authorize @role
    @role.destroy
    head :no_content
  end

  private

  def set_role
    @role = Role.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Role not found' }, status: :not_found
  end

  def role_params
    params.require(:role).permit(:name, :organization_id)
  end
end
