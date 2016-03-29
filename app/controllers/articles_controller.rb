class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end
  
  def show
    @article = Article.find_by(id: params[:id])
  end
  
  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:notice] = "The article was successfully created"
      redirect_to article_path(@article)
    else
      render action: :new
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

end
