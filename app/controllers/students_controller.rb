class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :show_errors

    def index
        render json: Student.all
    end

    def show
        student = find_student
        render json: student
    end

    def create
        student = Student.create!(student_params)
        render json: student
    end

    def update
        student = find_student
        student.update!(student_params)
        render json: student
    end

    def destroy
        student = find_student
        student.destroy
        render json: {message: "#{student.name} deleted"}
    end



    private

    def find_student
        Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :age, :major, :instructor_id)
    end 

    def render_not_found_response
        render json: {error: "That student doesn't exist!"}
    end

    def show_errors(invalid)
        render json: {errors: invalid.record.errors.full_messages}
    end

end
