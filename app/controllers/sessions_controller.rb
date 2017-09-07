# Sessions controller
# used to sign a user in and out
class SessionsController < ApplicationController
  skip_before_action :require_login, except: %w[destroy]
  layout 'application'

  def new
    @user = User.new
  end

  def create
    if (@user = login(params[:email], params[:password], params[:remember_me]))
      redirect_back_or_to root_path, success: 'Logged in successfully'
    else
      flash.now[:error] = 'Login failed'
      render action: :new
    end
  end

  def destroy
    logout
    redirect_to root_path, success: 'Logged out successfully'
  end
end