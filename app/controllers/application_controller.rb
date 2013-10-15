class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper
  include ApplicationHelper
  include ContactsHelper
  include MessagesHelper
  include NotificationsHelper
  include FriendshipsHelper
end
