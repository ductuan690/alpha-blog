class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, except: [:new, :index, :show, :create]
  before_action :require_same_user, only: [:edit, :update]


  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def show
    if @user.nil?
      flash[:danger] = "This user was not found"
      redirect_to users_path
    else
      @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.username} to Alpha Blog"
      redirect_to user_path(@user)
    else
      render action: :new
    end
  end

  def edit
    if @user.nil?
      flash[:danger] = "This user was not found"
      redirect_to articles_path
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "The #{@user.username} was successfully updated"
      redirect_to articles_path
    else
      render action: :edit
    end
  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @user
        flash[:danger] = "You just edit your own profile"
        redirect_to users_path
      end
    end

end
