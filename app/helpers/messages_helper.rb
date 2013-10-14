module MessagesHelper
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

end
