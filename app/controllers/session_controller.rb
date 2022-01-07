class SessionController < ApplicationController

  def create
    user=User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id]=user.id
      flash[:notice]="Logged in successfully"
      redirect_to articles_path
    else
      flash.now[:alert]="Wrong credentials. Try again."
      render 'new'
    end
  end
  def new

  end
  def destroy
    session[:user_id]=nil
    flash[:notice]="Logged out successfully"
    redirect_to root_path
  end
end