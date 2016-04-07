class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]
  before_action :require_admin, only: [:new, :create, :edit, :update]

  def new
    @category = Category.new
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)

    if @category.articles.empty?
      flash.now[:danger] = "There is no articles in this category"
    end
      render 'articles/index'
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

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "The category was successfully updated"
      redirect_to articles_path
    else
      render action: :edit
    end
  end

  private
    def category_params
      params.require(:category).permit(:category_name)
    end

    def set_category
      @category = Category.find_by(id: params[:id])
    end

    def require_admin
      if !logged_in? || (logged_in? and !current_user.admin?)
        flash[:danger] = "Only admin allowed to perform the action"
        redirect_to root_path
      end
    end

end
