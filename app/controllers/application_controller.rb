class ApplicationController < ActionController::Base
  helper_method :current_user, :isLoggedin
  def current_user
		@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
	end

	def isLoggedin
		!!current_user
	end

	def require_login
		if !isLoggedin
			flash[:alert]="You need to login to do that."
			redirect_to login_path
		end
	end

end
