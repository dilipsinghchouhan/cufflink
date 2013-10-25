include ActionView::Helpers::DateHelper

module ApplicationHelper
  
  def check_for_vip
    if params[:vip_tour]
      session[:vip_tour] = params[:vip_tour]
    end
  end
  
  #display
  def time_ago(obj)
    time_ago_in_words(obj.created_at) + " ago"
  end

  def states
    ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DC", "DE", "FL", "GA",
      "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
      "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
      "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
      "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
  end

  def plus
    '<i class="icon-plus editing"></i>'.html_safe
  end

  def x
    '<i class="icon-remove editing"></i>'.html_safe
  end

  def htmlize(body)
    body.gsub("\n","<br>").html_safe
  end

  def fancy_button(title, symbol, klass = nil, id = nil)
    html = '<button type="submit" class="buttony-link'

    html += ' ' + klass if klass
    html += '"'

    html += ' id="' + id + '"' if id

    html += '>' + symbol + " " + title + '</button>'

    html.html_safe
  end

  #editing/updating
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

  def clean_errors(object)
    errors = object.errors.full_messages

    p errors

    errors.delete_if { |e| e == "Deliveries is invalid" }

    return [] if errors.empty?

    errors.map! do |error|
      if error[0...8] == "Message "
        error[8..-1]
      else
        error
      end
    end

    html = (errors.length == 1) ? "<b>Error: </b> " : "<b>Errors: </b> "
    html += errors.join(", ")

    html.html_safe
  end

  #displayig profiles
  def has_address_info?(object)
    if object.is_a?(Company)
      object.address1 || object.address1 || object.city || object.state ||
        object.zip
    else
      object.city || object.state
    end
  end

  def has_info?(object)
    has_address_info?(object) || object.industry
  end

  def has_date_info?(experience)
    experience.current || experience.start_date || experience.end_date
  end
end