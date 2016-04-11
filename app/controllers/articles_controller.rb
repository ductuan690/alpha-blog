class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :show, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 4)
  end

  def show
    if @article.nil?
      flash[:danger] = "This article is not found"
      redirect_to articles_path
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)

    respond_to do |format|
      if @article.save
        flash[:success] = "The article was successfully created"

        format.js { render js: "window.location = '#{article_path(@article)}'" }
        format.html { rediret_to article_path(@article) }
      else
        format.js {}
        format.html { render action: :new }
      end
    end
  end

  def edit
    if @article.nil?
      flash[:danger] = "This article is not found"
      redirect_to articles_path
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        flash[:success] = "The article was successfully edited"

        format.js { render js: "window.location = '#{article_path(@article)}'" }
        format.html { redirect_to article_path(@article) }
      else
        format.js {}
        format.html { render action: :edit }
      end
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
      params.require(:article).permit(:title, :description, category_ids: [])
    end

    def require_same_user
      if current_user != @article.user and !current_user.admin?
        flash[:danger] = "You just edit on your own articles"
        redirect_to articles_path
      end
    end

end
