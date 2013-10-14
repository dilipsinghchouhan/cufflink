class FriendshipsController < ApplicationController
  before_filter :require_logged_in_user

  def create
    @friendship = Friendship.new(params[:friendship])
    @friendship.friender_id = current_user_id

    if @friendship.save
      flash[:notice] = "All good!"
      redirect_to user_url(@friendship.friendee_id)
    else
      flash[:errors] = @friendship.errors.full_messages
      redirect_to user_url(@friendship.friendee_id)
    end
  end

  def approve
    @friendship = Friendship.find_by_token(params[:code])

    if status_is_zero?(@friendship)
      @friendship.update_attributes(status: 1)
      create_new_friendship!(@friendship)
      send_approval_message!(@friendship)
    end

    redirect_to root_url
  end

  def deny
    @friendship = Friendship.find_by_token(params[:code])

    if status_is_zero?(@friendship)
      @friendship.update_attributes(status: 2)
      send_denial_message!(@friendship)
    end

    redirect_to root_url
  end

  def destroy

  end

  private

  def send_approval_message!(friendship)
    msg = UserMailer.connection_approval_email(friendship)
    msg.deliver!
  end

  def send_denial_message!(friendship)
    msg = UserMailer.connection_denial_email(friendship)
    msg.deliver!
  end

  def create_new_friendship!(friendship)
    @new_friendship = Friendship.new

    @new_friendship.message, @new_friendship.connection_type =
      friendship.message, friendship.connection_type

    @new_friendship.status = 1

    @new_friendship.friendee_id, @new_friendship.friender_id =
       friendship.friender_id, friendship.friendee_id

    @new_friendship.save
  end

  def status_is_zero?(friendship)
    if @friendship.status == 0
      return true
    else
      if @friendship.status == 1
        flash[:errors] = "This friendship has already been approved."
      else
        flash[:errors] = "This friendship has already been denied."
      end

      return false
    end
  end
end
