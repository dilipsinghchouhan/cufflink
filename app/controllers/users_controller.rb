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

    # new_user_params = {}
#
#     params[:user].each_pair do |key, value|
#       if value == ""
#         new_user_params[key] = nil
#       else
#         new_user_params[key] = value
#       end
#     end

    if @user.update_attributes(params[:user])
      render json: @user
    else
      render json: @user, status: 422
    end

    #this is the old edit page way...

    # @user = user_from_params
#
#     new_user_params = {}
#
#     params[:user].each_pair do |key, value|
#       if value == ""
#         new_user_params[key] = nil
#       else
#         new_user_params[key] = value
#       end
#     end
#
#     if @user.update_attributes(new_user_params)
#       flash[:notice] = "Update Successful!"
#       redirect_to user_url(@user)
#     else
#       flash[:errors] = @user.errors.full_messages
#       render :edit
#     end
  end

  def feed
    render :feed
  end

  private

  def user_from_params
    User.find_by_id(params[:id])
  end
end
