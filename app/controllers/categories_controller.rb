class CategoriesController < ApplicationController
  before_action :require_admin, only: [:new, :create]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "The category was successlly created"
      redirect_to articles_path
    else
      render action: :new
    end
  end

  private
    def category_params
      params.require(:category).permit(:category_name)
    end

    def require_admin
      if !logged_in? || (logged_in? and !current_user.admin?)
        flash[:danger] = "Only admin allowed to perform the action"
        redirect_to root_path
      end
    end

end
