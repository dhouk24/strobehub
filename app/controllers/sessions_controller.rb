class SessionsController < ApplicationController
	skip_before_filter :require_login

	def login
		user = User.find_by_username(params[:sessions][:username])
		if user && user.authenticate(params[:sessions][:password])
			session[:user_id] = user.id
			flash[:success] = "You successfully logged in"
			redirect_to user_path(user)
		else
			flash[:error] = "Unsuccessful login attempt"
			redirect_to login_path
		end
	end

	def logout
		session.clear
		flash[:success] = "You successfully logged out"
		redirect_to :root
	end
end
