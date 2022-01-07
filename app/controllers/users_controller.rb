class UsersController < ApplicationController
	before_action :set_user, only: %i[show edit update destroy]
	before_action :require_login, only: %i[edit update destroy]
	before_action :require_same_user, only: %i[edit update destroy]

	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	def new
		@user = User.new
	end

	def show
		@articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end

	def edit; end

	def update
		if @user.update(user_params)
			flash[:notice] = 'Profile updated successfully'
			redirect_to @user
		else
			render 'edit'
		end
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "User SignedUp Successfully, Welcome to Alpha Blog #{@user.username}"
			redirect_to articles_path
		else
			render 'new'
		end
	end

	def destroy
		if @user.destroy
			session[:user_id] = nil if @user=current_user
			flash[:notice] = 'User profile deleted successfully'
			redirect_to root_path
		else
			render 'index'
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end

	def require_same_user
		if current_user != @user && !current_user.admin?
			flash[:alert] = 'You cannot do that!!'
			redirect_to @user
		end
	end
end
