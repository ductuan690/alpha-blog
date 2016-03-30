class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :show, :update, :destroy]
  
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def show
    if @article.nil?
      flash[:notice] = "This article is not found"
      redirect_to articles_path
    end
  end

  def edit
    if @article.nil?
      flash[:notice] = "This article is not found"
      redirect_to articles_path
    end
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

  def update
    if @article.update(article_params)
      flash[:notice] = "The article was successfully edited"
      redirect_to article_path(@article)
    else
      render action: :edit
    end
  end

  def destroy
    @article.destroy

    flash[:notice] = "The article was deleted"
    redirect_to articles_path
  end

  private
    def set_article
      @article = Article.find_by(id: params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end
end
