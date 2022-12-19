class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :rescue_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found

  def index 
    render json: Student.all, status: :ok
  end

  def show
    student = Student.find_by!(id: params[:id])
    render json: student, status: :ok
  end

  def update
    student = Student.find_by!(id: params[:id])
    student.update(stdnt_params)
    render json: student, status: :accepted
  end

  def create 
    render json: Student.create!(stdnt_params), status: :created
  end

  def destroy
    student = Student.find_by!(id: params[:id])
    student.destroy
    student.missions.destroy_all
    head :no_content
  end

  private

  def rescue_invalid(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def rescue_not_found
    render json: {error: "Student not found"}, status: :not_found
  end

  def stdnt_params
    params.permit(:name, :major, :age, :instructor_id)
  end
end
