class RatingsController < ApplicationController

	def create
		@movie  = Movie.find(params[:movie_id])
		@rating = @movie.ratings.new(
			score: params[:score],
			user_id: current_user.id
		)
		if @rating.save
			redirect_to movies_path
		else
			render json: { error: @rating.errors[:rated] }
		end

	end

end