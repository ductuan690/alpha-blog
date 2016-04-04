class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to user_path(current_user)
    end
  end

  def create
    user = User.find_by(email: params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You was successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There's something wrong with your login information"
      render action: :new
    end
    #render plain: user
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
