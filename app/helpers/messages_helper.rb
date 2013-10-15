module MessagesHelper
  def author_link(message)
    url = message.user ? user_url(message.user) : company_url(message.company)

    html = '<a href="' + url + '">' + message.author.name + '</a>'

    html.html_safe
  end

  def get_from_select
    html = '<select name="sender">'
    html += '<option value="user">Me</option>'

    current_user.managed_companies.each do |company|
      html += '<option value="' + company.id.to_s + '">'
      html += company.name + '</option>'
    end

    html += '</select>'

    html.html_safe
  end

  def get_reply_link(message, all = false)
    recipients = [@message.user]
    recipients += @message.recipients if all

    link = new_message_url + "?"
    params = []

    recipients.each_with_index do |recipient,i|
      next if recipient == current_user

      params << "reply[#{i}]=#{recipient.id.to_s}"
    end

    link + params.join("&")
  end

  def get_forward_link(message)
    link = new_message_url + "?body=%0A%0A%0A%0A%0A"

    recipient_names = message.recipients.map(&:name).join(", ")

    link += "------ FORWARDED MESSAGE ------%0A"
    link += "From: #{message.author.name}%0A"
    link += "Date: #{message.created_at}%0A"
    link += "Subject: #{message.subject}%0A"
    link += "To: #{recipient_names}%0A%0A"

    link += "#{encode(message.body)}"

  end

  def encode(body)
    body.gsub("\n","%0A")
  end

end
