class UsersController < ApplicationController
  before_filter :require_logged_in_user, except: [:new, :create]
  before_filter :prohibit_logged_in_user, only: [:new, :create]
  before_filter :require_profile_owner, only: [:edit, :update]

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
    @user = user_from_params

    render :show
  end

  def edit
    @user = user_from_params

    render :edit
  end

  def update
    @user = user_from_params

    if @user.update_attributes(params[:user])
      render json: @user
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def feed
    render :feed
  end

  private

  def user_from_params
    User.find_by_id(params[:id])
  end
end
