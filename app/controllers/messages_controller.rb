class MessagesController < ApplicationController
  before_filter :require_logged_in_user

  # nested routes
  def index
    @messages = current_user.received_messages.includes(:user)
    @type = "Incoming"

    render :index
  end

  def sent
    @messages = current_user.sent_messages.includes(:recipients)
    @type = "Sent"

    render :index
  end

  # un-nested routes
  def new
    @message = Message.new

    render :new
  end

  def create
    # a message can be sent to multiple recipients, so we're using
    # a transaction to safely create a delivery model for each recipient
    begin
      ActiveRecord::Base.transaction do
        @message = Message.new(params[:message])

        sender = params[:sender]

        if sender == "user"
          @message.user = current_user
        else
          @message.company_id = sender.to_i
        end

        @message.save

        # recipients show up in a hash like {"1" => "Bob Smith", "2" => etc...}
        @deliveries = params[:recipients].map do |_, name|
          raise "name must be at least 2 words" unless name.include?(" ")

          user = User.find_by_name(name)

          raise "user not found" unless user

          @message.deliveries.create(user_id: user.id)
        end

        raise "invalid" unless @message.valid? &&
          @deliveries.all? { |d| d.valid? }
      end
    rescue
      flash[:errors] = @message.errors.full_messages
      flash[:errors] += @deliveries.map { |d| d.errors.full_messages }

      render :new
    else
      flash[:notice] = "Message sent!"
      redirect_to user_messages_url(current_user)
    end
  end

  def autocomplete
    n = params[:recipient_number]

    render partial: "shared/autocomplete", locals: { url: users_url, id: n,
      field: '#name_' + n, hidden_field: '#recipient_' + n, type: "user" }
  end

  #make a .author method that will return the company or the user!!!

  def show
    @message = Message.find_by_id(params[:id])

    @message.unread = false
    @message.save

    @author = @message.user
    @recipients = @message.recipients

    @sender = @message.company_id ?
      Company.find(@message.company_id) : current_user

    @received = @message.recipients.include?(current_user)

    render :show
  end
end
