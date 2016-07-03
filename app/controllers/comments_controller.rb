class CommentsController < ApplicationController

	def create
		movie = Movie.find(params[:movie_id]) 
		comment = movie.comments.create(comment_params)
		comment.update_attributes(user_id: current_user.id)
		redirect_to movies_path
	end

	private

	def comment_params
		params.require(:comment).permit(:content)
	end

end