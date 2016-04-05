class CategoriesController < ApplicationController
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

end
