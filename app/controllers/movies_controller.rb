class MoviesController < ApplicationController

	before_filter :authenticate

	def index
		@movies = Movie.search(params[:query], params[:runtime]).order(:title).page(params[:page]).per(4)
		@comment = Comment.new
	end

	def new
		@movie = Movie.new
	end

	def create
		@movie = current_user.movies.create(movie_params)
		if @movie
			redirect_to action: 'index'
		else
			render :new
		end
	end

	def edit
		@movie = Movie.find(params[:id])
	end

	def update
		@movie = Movie.update(params[:id], movie_params)
		if @movie.save
			redirect_to action: 'index'
		else
			render :edit
		end
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy if @movie
		redirect_to action: 'index'
	end

	private

	def movie_params
		params.require(:movie).permit(:title, :director, :poster, :runtime, :release_date)
	end

end
