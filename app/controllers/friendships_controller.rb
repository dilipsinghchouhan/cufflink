class FriendshipsController < ApplicationController
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
    @friendship.update_attributes(status: 1)

    send_approval_message!(@friendship)

    redirect_to root_url
  end

  def deny
    @friendship = Friendship.find_by_token(params[:code])
    @friendship.update_attributes(status: 2)

    send_denial_message!(@friendship)

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
end
