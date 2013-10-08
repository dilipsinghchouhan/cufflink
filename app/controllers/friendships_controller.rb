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

  def destroy

  end
end
