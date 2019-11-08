class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if current_user.user_type == 'admin'
        redirect_to admin_users_path, notice: 'you logged in as Admin'
        else
          redirect_to tasks_path, notice: 'you logged in as User'
          end
    else
      flash.now[:danger] = 'Login failed'
      render 'new'
    end
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'You logged out'
    redirect_to new_session_path
  end
end
