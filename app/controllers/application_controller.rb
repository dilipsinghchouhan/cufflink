class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_for_notification, :check_for_vip

  include SessionsHelper
  include ApplicationHelper
  include ContactsHelper
  include MessagesHelper
  include NotificationsHelper
  include FriendshipsHelper
end
