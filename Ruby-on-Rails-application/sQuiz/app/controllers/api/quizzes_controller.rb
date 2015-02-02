module Api
	class QuizzesController < ApplicationController
		#before_action :authenticate_instructor!, only: [:create,:destroy,:show,:index]
		respond_to :json

		#This method is used to get quiz by taking the quiz id from the client.
		def show
			quiz = current_instructor.quizzes.find(params[:id])
			render json: quiz, status: 200
		end
		#This method creates new quiz by taking the quiz attributes from JSON object 
		#and it returns the JSON representation of the newly created object and its location.
		def create
			quiz = Quiz.new(quiz_params)
			if quiz.save
				current_instructor.quizzes << quiz
				render json: quiz, status: 201
			else
				render json: quiz.errors, status: 422
			end
		end
		private
		def quiz_params
			params.require(:quiz).permit(:name, :subject, :duration, :no_of_MCQ, :no_of_rearrangeQ)
		end
	end
end