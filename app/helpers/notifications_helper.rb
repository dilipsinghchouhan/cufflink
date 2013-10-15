module NotificationsHelper
  def parse_notification(notification)
    case notification.notifiable_type

    when "Friendship"
      link_dest, link_text, action = parse_friendship(notification.notifiable)
    end

    if notification.unread?
      link_text = "<b>#{link_text}</b>"
    end

    html = "<a href=\"#{link_dest}\">#{link_text}</a>"
    html += "<span class=\"action\">#{action}</span>"


    html += "<a href=\"\" class=\"mark-read\">Mark Read</a>"

    html.html_safe
  end

  def create_friendship_notification!(friendship)
    friendship.notifications.create(user_id: friendship.friendee_id)
  end

  def update_friendship_notications!(friendship)
    friendship.notifications.first.destroy
    friendship.notifications.create(user_id: friendship.friender_id)
  end

  private

  def parse_friendship(friendship)
    action = nil

    case friendship.status
    when 0
      friender = friendship.friender

      link_dest = user_url(friender)

      link_text = "You have a pending connection request from
        #{friender.name}"

      action = approve_deny_links(friender)
    else
      friendee = friendship.friendee

      link_dest = user_url(friendee)

      verb = (friendship.status == 1) ? "approved" : "denied"

      link_text = "#{friendee.name} has #{verb} your connection request."
    end

    [link_dest, link_text, action]
  end

end
