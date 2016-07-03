module MoviesHelper

	def rating(movie, user)
		rating = Rating.where(movie_id: movie.id, user_id: user.id).first
		rating.score if rating 	
	end

end
