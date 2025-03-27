class DesignationsController < ApplicationController
  before_action :set_department
  before_action :set_designation, only: %i[show update destroy]

  def index
    @designations = @department.designations
    render json: @designations
  end

  def show
    authorize @designation
    render json: @designation
  end

  def create
    @designation = @department.designations.new(designation_params)
    authorize @designation
    if @designation.save
      render json: @designation, status: :created
    else
      render json: @designation.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @designation
    if @designation.update(designation_params)
      render json: @designation
    else
      render json: @designation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @designation
    @designation.destroy
    head :no_content
  end

  private

  def set_designation
    @designation = Designation.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Designation not found' }, status: :not_found
  end

  def set_department
    @department = Department.find(params[:department_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Department not found' }, status: :not_found
  end

  def designation_params
    params.require(:designation).permit(:name, :department_id)
  end
end
