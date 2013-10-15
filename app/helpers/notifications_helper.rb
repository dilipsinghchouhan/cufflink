module NotificationsHelper
  def parse_notification(notification)
    case notification.notifiable_type

      #clean these up with send...
    when "Friendship"
      link_dest, link_text, action = parse_friendship(notification.notifiable)
    when "Response"
      link_dest, link_text, action = parse_response(notification.notifiable)
    end

    if notification.unread?
      link_text = "<b>#{link_text}</b>"
    end

    link_dest += "?notification=#{notification.id}"

    html = "<a href=\"#{link_dest}\"><div class=\"link-text\">"
    html += "#{link_text}</div></a>"
    html += "<div class=\"action\">#{action}</div>"

    html += get_delete_link(notification)

    html.html_safe
  end

  def create_friendship_notification!(friendship)
    friendship.notifications.create(user_id: friendship.friendee_id)
  end

  def create_response_notification!(response)
    response.notifications.create(user_id: response.status.user_id)
  end

  def update_friendship_notications!(friendship)
    friendship.notifications.first.destroy
    friendship.notifications.create(user_id: friendship.friender_id)
  end

  def check_for_notification
    if params[:notification]
      notification = Notification.find_by_id(params[:notification].to_i)
      notification.unread = false
      notification.save!
    end
  end

  private

  def parse_response(response)
    action = nil

    link_dest = user_url(current_user) #find a way to go to specific status

    if response.is_like?
      user = response.user
      status_excerpt = response.status.excerpt

      link_text = "#{user.name} liked your <span class=\"excerpt\">"
      link_text += "#{status_excerpt}</span>"
    else

    end

    [link_dest, link_text, action]
  end

  def parse_friendship(friendship)
    action = nil

    case friendship.status
    when 0
      friender = friendship.friender

      link_dest = user_url(friender)

      link_text = "You have a pending connection request from #{friender.name}"
      link_text += "<div class=\"message\">Message: "
      link_text += "<i>#{friendship.message}</i></div>"

      action = approve_deny_links(friender)
    else
      friendee = friendship.friendee

      link_dest = user_url(friendee)

      verb = (friendship.status == 1) ? "approved" : "denied"

      link_text = "#{friendee.name} #{verb} your connection request."
    end

    [link_dest, link_text, action]
  end

  def get_delete_link(notification)
    link_to raw("<i class=\"icon-remove-sign\"></i>"),
      notification_url(notification), method: :delete, remote: true,
      class: "delete-link"

  end
end
