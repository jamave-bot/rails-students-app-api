class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :show_errors

    def index
        render json: Instructor.all
    end

    def show
        instructor = find_instructor
        render json: instructor
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor
    end

    def update
        instructor = find_instructor
        instructor.update!(instructor_params)
        render json: instructor
    end

    def destroy
        instructor = find_instructor
        instructor.destroy
        render json: {message: "#{instructor.name} deleted"}
    end




    private


    def find_instructor
        Instructor.find(params[:id])
    end

    def instructor_params
        params.permit(:name)
    end

    def render_not_found_response
        render json: {error: "That instructor doesn't exist!"}
    end

    def show_errors(invalid)
        render json: {errors: invalid.record.errors.full_messages}
    end

end
