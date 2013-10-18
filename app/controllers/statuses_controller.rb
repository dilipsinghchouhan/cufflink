class StatusesController < ApplicationController
  before_filter :require_logged_in_user

  def create
    @status = Status.new(clean_params_hash(params[:status]))

    @status.user_id = params[:user_id] if params[:user_id]
    @status.company_id = params[:company_id] if params[:company_id]

    @status.pic = params[:pic] if params[:pic]

    if @status.save & request.xhr?
      render partial: "show", locals:
      { object: @status, klass: "two-thirds pod first" }
    elsif @status.errors.full_messages.empty?
      flash[:notice] = "Status saved!"
      redirect_to :back
    elsif request.xhr?
      render json: clean_errors(@status), status: 422
    else
      flash[:errors] = @status.errors.full_messages
      redirect_to :back
    end
  end

  def new
    @status = Status.new

    if request.xhr?
      render partial: "statuses/new", locals: { type: "user",
        object: current_user }
    else
      render :new
    end
  end
end
