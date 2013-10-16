class MessagesController < ApplicationController
  before_filter :require_logged_in_user

  # nested routes
  def index
    order = get_order(params[:order])

    if params[:sent]
      @messages = current_user.sent_messages
      @type = "Sent"
    else
      @messages = current_user.received_messages
      @type = "Incoming"
    end

    @messages = @messages.order(order).includes(:user)

    render :index
  end

  # un-nested routes
  def new
    @message = Message.new
    @message.body = params[:body] ? params[:body] : ""

    @reply_recipients = []

    if params[:reply]
      # they come in looking like "reply" => { "1" > "7" }
      # where 7 is the user id
      params[:reply].each do |_, user_id_string|
        @reply_recipients << User.find_by_id(user_id_string.to_i)
      end
    end

    if request.xhr?
      render partial: "new", locals: { reply_recipients: @reply_recipients,
        message: @message }
    else
      render :new
    end
  end

  def create
    # a message can be sent to multiple recipients, so we're using
    # a transaction to safely create a delivery model for each recipient
    begin
      ActiveRecord::Base.transaction do
        @message = Message.new(params[:message])

        sender = params[:sender]

        # every message has a user. some also have a company id.
        @message.user = current_user
        @message.company_id = sender.to_i unless sender == "user"

        @message.save

        # recipients show up in a hash like {"1" => "Bob Smith", "2" => etc...}
        @deliveries = []

        params[:recipients].each do |_, name|
          user = User.find_by_name(name)

          raise ArgumentError.new "user not found" unless user

          @deliveries << @message.deliveries.create(user_id: user.id)
        end

        raise "invalid" unless @message.valid? &&
          @deliveries.all? { |d| d.valid? }
      end
    rescue
      flash[:errors] = clean_errors(@message)

      delivery_errors = @deliveries
        .map { |d| clean_errors(d) }
        .delete_if { |d| d.empty? }

      flash[:errors] += delivery_errors

      @message.body = ""
      @reply_recipients = []

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

  def show
    @message = Message.find_by_id(params[:id])

    if @message.received_by?(current_user)
      @message.get_delivery(current_user).mark_as_read!
    end

    @message.save

    @recipients = @message.recipients

    render :show
  end

  private

  def get_order(order_params)
    order_params ? order_params.gsub("-", " ") : "created_at DESC"
  end
end
