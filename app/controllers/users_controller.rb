class UsersController < ApplicationController
  before_filter :require_logged_in_user, except: [:new, :create]
  before_filter :prohibit_logged_in_user, only: [:new, :create]
  before_filter :require_profile_owner, only: [:edit, :update]

  def index
    if params[:term]
      names = []
      @experiences = []
      matched_users = []

      array = User.find(:all, conditions:
        ['first_name LIKE ? OR last_name LIKE ?',
         "%#{params[:term]}%", "%#{params[:term]}%"])

      array.each do |user|
        unless names.include?(user.name)
          names << user.name
          matched_users << user
        end
      end

      @users = matched_users + [User.new(first_name: params[:term])]
    else
      @users = User.all
    end

    @users -= [current_user]

    respond_to do |format|
      format.json { render json: @users.to_json }
      format.html { render :index }
    end
  end

  def connections
    @users = current_user.connections
    render :connections
  end

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

  def settings
    @company = params[:company]

    render :settings
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
    @data, @statuses = current_user.get_feed_data

    render :feed
  end

  private

  def user_from_params
    User.find_by_id(params[:id])
  end
end
