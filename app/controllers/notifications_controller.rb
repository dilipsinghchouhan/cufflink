class NotificationsController < ApplicationController
  def destroy
    @notification = Notification.find_by_id(params[:id])

    @notification.destroy

    if request.xhr?
      render json: @notification
    else
      flash[:notice] = "Notification successfully deleted!"
      redirect_to root_url
    end
  end
end
