class CategoriesController < ApplicationController
  before_action :require_admin, except:[:show,:index]

  def index
    @categories=Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @category=Category.find(params[:id])
  end

  def new
    @category=Category.new
  end
  
  def create
    @category=Category.new(category_params)
    if @category.save
      flash[:notice]="Category created sucessfully"
      redirect_to @category
    else
      render "new"
    end
  end
  
  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(isLoggedin && current_user.admin?)
      flash[:alert]="Only admin can do that."
        redirect_to categories_path
    end
  end
end