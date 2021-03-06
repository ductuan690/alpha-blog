class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to user_path(current_user)
    end
  end

  def create
    user = User.find_by(email: params[:session][:email])

    respond_to do |format|
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        flash[:success] = "You was successfully logged in"

        format.js { render js: "window.location = '#{user_path(user)}'" }
        format.html { user_path(user) }
      else
        flash.now[:danger] = "There's something wrong with your login information"

        format.js {}
        format.html { render action: :new }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
