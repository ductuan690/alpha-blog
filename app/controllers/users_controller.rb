class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome #{@user.username} to Alpha Blog"
      redirect_to articles_path
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

end
