class PagesController < ApplicationController
	def home
		redirect_to articles_path if isLoggedin
	end
	def about; end
end
