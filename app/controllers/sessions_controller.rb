class SessionsController < ApplicationController

	def create
		user = User.find_by_username(params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to movies_path
		else 
			redirect_to '/login'
		end
	end

	def destroy
		session.clear
		redirect_to new_session_path
	end

end
