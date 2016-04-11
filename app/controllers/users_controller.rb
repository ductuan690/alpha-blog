class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:new, :index, :show, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

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

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Welcome #{@user.username} to Alpha Blog"

        format.js { render js: "window.location = '#{user_path(@user)}'" }
        format.html { redirect_to user_path(@user) }
      else
        format.js { }
        format.html { render action: :new }
      end
    end
  end

  def edit
    if @user.nil?
      flash[:danger] = "This user was not found"
      redirect_to articles_path
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = "The #{@user.username} was successfully updated"

        format.js { render js: "window.location = '#{user_path(@user)}'" }
        format.html { redirect_to user_path(@user) }
      else
        format.js {}
        format.html { render action: :edit }
      end
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = "The user and all articles created by the user was successfully deleted"
    redirect_to users_path
  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def require_same_user
      if current_user != @user and !current_user.admin?
        flash[:danger] = "You just edit your own profile"
        redirect_to users_path
      end
    end

    def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger] = "Only admin allowed to perform the action"
        redirect_path users_path
      end
    end

end
