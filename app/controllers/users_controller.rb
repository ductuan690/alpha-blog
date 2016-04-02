class UsersController < ApplicationController
  def new
    @user = User.new
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
    @user = User.find_by(id: params[:id])

    if @user.nil?
      flash[:danger] = "This user was not found"
      redirect_to articles_path
    end
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user.update(user_params)
      flash[:success] = "The #{@user.username} was successfully updated"
      redirect_to articles_path
    else
      render action: :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

end
