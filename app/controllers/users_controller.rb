class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = "Sign Up Successful!"
      #add some confirmation email stuff
      redirect_to root_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update

  end

  def feed
    render :feed
  end
end
