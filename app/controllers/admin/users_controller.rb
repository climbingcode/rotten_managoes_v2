class Admin::UsersController < ApplicationController

	before_filter :is_admin

	def index 
		@users = User.all.exclude(current_user)
	end

	def show 
		@user = User.find(params[:id])
	end

	def edit 
		@user = User.find(params[:id])
	end

	def update 
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			redirect_to '/admin/users'
		else 
			render :edit
		end
	end

	def destroy 
		@user = User.find(params[:id])
		redirect_to '/admin/users' if @user.destroy
	end

	def browse_as
		if session[:admin_id]
			session[:user_id]  = session[:admin_id]
			session[:admin_id] = nil
			redirect_to admin_users_path
		else
			session[:admin_id] = current_user.id
			session[:user_id]  = params[:format]
			redirect_to movies_path
		end
	end

	private

	def is_admin
		unless current_user.admin || User.find(session[:admin_id])
			redirect_to '/movies'
		end
	end

	def user_params
		params.require(:user).permit(:username, :password, :admin, :password_confirmation, :email)
	end

end
