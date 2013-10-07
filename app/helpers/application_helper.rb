module ApplicationHelper
  def industry_select(model_name, selected_industry)
    industries = [
      "Real Estate",
      "Technology",
      "Advertising",
      "Hospitality",
      "Health/Medicine",
      "Banana Stand",
      "Other"
    ]

    html = '<select name="' + model_name + '[industry]">'
    html += "<option value="">Select an Industry</option>"

    industries.each do |industry|
      html += '<option value="' + industry + '"'

      if industry == selected_industry
        html += " selected"
      end

      html += ">" + industry + "</option>"
    end

    html += "</select>"

    html.html_safe
  end
end
