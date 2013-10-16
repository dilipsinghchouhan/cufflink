class ContactsController < ApplicationController
  before_filter :require_logged_in_user

  def new
    @type, @display_text, @is_company, @creator_id = get_info

    @contact = Contact.new

    if request.xhr?
      render partial: "new", locals: { contact: @contact, type: @type,
        display_text: @display_text, is_company: @is_company,
        creator_id: @creator_id }
    else
      render :new
    end
  end

  def create
    @type, @display_text, @is_company, @creator_id = get_info

    @redirect_url = @is_company ? company_url(@creator_id) :
      user_url(current_user)

    @contact = Contact.new(clean_params_hash(params[:contact]))

    @contact.contact_type = @type

    if @is_company
      @contact.company_id = @creator_id
    else
      @contact.user_id = current_user.id
    end

    if @contact.save
      flash[:notice] = @display_text + " saved successfully!"
      redirect_to @redirect_url
    else
      flash[:errors] = @contact.errors.full_messages
      redirect_to @redirect_url
    end
  end

  def destroy
    @contact = Contact.find_by_id(params[:id])

    @contact.destroy

    if request.xhr?
      render json: @contact
    else
      flash[:notice] = @contact.value + " deleted successfully!"
      redirect_to :back
    end
  end

  private

  def get_display_text(type)
    case type

    when 0
      "Email Address"
    when 1
      "Phone Number"
    when 2
      "Website Address"
    end
  end

  def get_info
    info = []

    #@type
    #ex: 0
    type = params[:type].to_i
    info << type

    #@display_text
    #ex: "Email Address"
    info << get_display_text(type)

    #@is_company
    #ex: false
    info << params[:company_id] ? true : false

    #@creator_id
    #ex: 1
    creator_id = params[:company_id] ? params[:company_id] : params[:user_id]
    info << creator_id.to_i

    info
  end
end
