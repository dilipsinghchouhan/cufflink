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
    
    if link_dest.include?("?")
      link_dest += "&"
    else
      likn_dest += "?"
    end

    link_dest += "notification=#{notification.id}"
    
    link_dest += "&vip_tour=9" if cookies[:vip_tour]

    html = "<a href=\"#{link_dest}\">"
    html += "<div class=\"link-text\">#{link_text}</div></a>"
    html += get_delete_link(notification)
    html += "<div class=\"action\">#{action}</div>"

    html.html_safe
  end

  def create_friendship_notification!(friendship)
    friendship.notifications.create(user_id: friendship.friendee_id)
  end

  # def create_response_notification!(response)
#     response.notifications.create(user_id: response.status.user_id)
#   end

  def update_friendship_notications!(friendship)
    friendship.notifications.first.destroy
    friendship.notifications.create(user_id: friendship.friender_id)
  end

  def check_for_notification
    if params[:notification]
      notification = Notification.find_by_id(params[:notification].to_i)
      if notification
        notification.unread = false
        notification.save!
      end
    end
  end

  private

  def parse_response(response)
    action = nil

    link_dest = _url(current_user) + "?nav=status"
    
    p "RESPONSE ISSSS"
    p response

    user = response.user
    status_excerpt = response.status.excerpt

    if response.is_like?
      link_text = "#{user.name} liked your <span class=\"excerpt\">"
      link_text += "#{status_excerpt}</span>"
    else
      link_text = "#{user.name} commented on your <span class=\"excerpt\">"
      link_text += "#{status_excerpt}</span>"
      link_text += "<div class=\"message\">Comment:"
      link_text += "<div>#{response.body}</div></div>"
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
      link_text += "<div>#{friendship.message}</div></div>"

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

    link_to raw("<i class=\"icon-remove\"></i>"),
      notification_url(notification), method: :delete, remote: true,
      class: "delete-link"

  end
end
