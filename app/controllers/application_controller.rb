class ApplicationController < ActionController::Base
  helper_method :current_user, :isLoggedin
  def current_user
		@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
	end

	def isLoggedin
		!!current_user
	end

end
