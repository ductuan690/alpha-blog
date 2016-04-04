class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :show, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 4)
  end

  def new
    @article = Article.new
  end

  def show
    if @article.nil?
      flash[:danger] = "This article is not found"
      redirect_to articles_path
    end
  end

  def edit
    if @article.nil?
      flash[:danger] = "This article is not found"
      redirect_to articles_path
    end
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:success] = "The article was successfully created"
      redirect_to article_path(@article)
    else
      render action: :new
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "The article was successfully edited"
      redirect_to article_path(@article)
    else
      render action: :edit
    end
  end

  def destroy
    @article.destroy

    flash[:danger] = "The article was deleted"
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
