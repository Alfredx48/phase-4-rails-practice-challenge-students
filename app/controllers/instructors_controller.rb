class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :rescue_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found

  def index 
    render json: Instructor.all, status: :ok
  end

  def show
    instructor = Instructor.find_by!(id: params[:id])
    render json: instructor, status: :ok
  end

  def update
    instructor = Instructor.find_by!(id: params[:id])
    instructor.update(inst_params)
    render json: instructor, status: :accepted
  end

  def create 
    render json: Instructor.create!(inst_params), status: :created
  end

  def destroy
    instructor = Instructor.find_by!(id: params[:id])
    instructor.destroy
    head :no_content
  end

  private

  def rescue_invalid(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def rescue_not_found
    render json: {error: "Instructor not found"}, status: :not_found
  end

  def inst_params
    params.permit(:name)
  end
end
