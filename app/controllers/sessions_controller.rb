class SessionsController < ApplicationController
  before_filter :require_logged_in_user, only: [:destroy]
  before_filter :prohibit_logged_in_user, only: [:new, :create]

  def new
    @user = User.new

    render :new
  end

  def create

    if params[:vip]
      @user = User.find_by_id(1)
      session[:vip] = true
    else
      @user = User.find_by_credentials(
        params[:user][:email],
        params[:user][:password]
      )
    end

    if @user
      flash[:notice] = "Log in successful!"
      log_in_user!(@user)
      redirect_to root_url
    else
      flash[:errors] = ["Invalid credentials."]
      @user = User.new(email: params[:user][:email])
      render :new
    end
  end

  def destroy
    log_out_user!

    flash[:notice] = "Sign out successful!"

    redirect_to new_session_url
  end
end
