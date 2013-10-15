class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_for_notification

  include SessionsHelper
  include ApplicationHelper
  include ContactsHelper
  include MessagesHelper
  include NotificationsHelper
  include FriendshipsHelper
end
