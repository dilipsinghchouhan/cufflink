module ContactsHelper
  def gen_contact_select(type, is_company)
    html = '<select id="contact-select" name="contact[name]">'
    html += '<option>Select an Option</option>'

    get_options(type, is_company).each do |option|
      html += '<option value="' + option + '">' + option + '</option>'
    end

    html += '<option value="Other">Other</option>'
    html += '</select>'

    html.html_safe
  end

  def get_options(type, is_company)
    case type
    when 0
      if is_company
        ["Company", "Support", "Sales", "PR", "Job Opportunities"]
      else
        ["Personal", "Office"]
      end
    when 1
      if is_company
        ["Company", "Support", "Sales", "PR", "Toll-Free"]
      else
        ["Home", "Office", "Mobile"]
      end
    when 2
      if is_company
        ["Company", "Facebook", "Twitter"]
      else
        ["Personal", "Company", "Facebook", "Twitter"]
      end
    end
  end

  def contacts(object, type)
    case type
    when "Email Addresses"
      num = "0"
      link = "mailto:"
    when "Phone Numbers"
      num = "1"
    when "Websites & Online Profiles"
      num = "2"
    end

    object.contacts.where("contact_type = '#{num}'")
  end

  def display_contact(contact)
    case contact.contact_type

    when 0
      html = '<a href="mailto:' + contact.value + '">'
      html += contact.value + '</a>'
    when 1
      html = contact.value
    when 2
      html = '<a href="' + contact.value + '">'
      html += contact.value + '</a>'
    end

    html
  end
end
