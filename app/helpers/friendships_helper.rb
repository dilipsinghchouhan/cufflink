module FriendshipsHelper
  def approve_deny_links(user)
    token = Friendship
      .find_by_friender_id_and_friendee_id(user.id, current_user.id).token

    html = get_link_html("Approve", token) + " / "
    html += get_link_html("Deny", token)

    html.html_safe
  end

  def get_link_html(type, token)
    if type == "Approve"
      link = friendships_approve_url
    else
      link = friendships_deny_url
    end

    "<a href=\"#{link}?code=#{token}\">#{type}</a>"
  end

  def friendship_status(user)

    status = current_user.friendship_status_with(user)

    html = "<li class=\"friendship-status\">"

    if status == :not_connected
      title = "Not Connected"
      klass = "icon-user"

      html = "<li class=\"button\">"

      link_start = "<a href=\"#{new_user_friendship_url(user)}\""
      link_start += "data-remote=\"true\" class=\"gen-modal\">"

      link_end = " Request Connection</a>"

    elsif status == :connected
      title = "Current Connection"
      klass = "icon-user connected"
    elsif status == :denied
      title = "Connection Request Denied"
      klass = "icon-remove-sign"
    elsif status == :request_pending || status == :receipt_pending
      title = "Connection Request Pending"
      klass = "icon-time"
      extra = approve_deny_links(user) if status == :receipt_pending
    end

    html += link_start if link_start

    html += "<abbr class=\"friendship-status\" title=\"#{title}\">"
    html += "<i class=\"#{klass}\"></i></abbr>"

    html += link_end if link_end

    html += "</li>"

    html.html_safe
  end
end
