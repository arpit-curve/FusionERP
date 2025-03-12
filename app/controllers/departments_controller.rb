class DepartmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_department, only: %i[show update destroy]

  def index
    render json: Department.all
  end

  def show
    render json: @department
  end

  def create
    department = Department.build(department_params)

    if department.save
      render json: department, status: :created
    else
      render json: { errors: department.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @department.update(department_params)
      render json: @department
    else
      render json: { errors: @department.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @department.destroy
    head :no_content
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :organization_id)
  end
end
