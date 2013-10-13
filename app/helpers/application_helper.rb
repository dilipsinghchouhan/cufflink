module ApplicationHelper
  def industry_select(model_name, selected_industry, field_name = "industry")
    industries = [
      "Real Estate",
      "Technology",
      "Advertising",
      "Hospitality",
      "Health/Medicine",
      "Banana Stand",
      "Other"
    ]

    html = '<select name="' + model_name + '[' + field_name + ']">'
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

  def city_state(object)
    object.city
    ", " unless object.state.nil? || object.city.nil?
    object.state
  end

  def states
    ["NY", "CA"]
  end

  def clean_params_hash(params)
    {}.tap do |new_params|
      params.each do |key, value|
        if value == ""
          new_params[key] = nil
        else
          new_params[key] = value
        end
      end
    end
  end
end