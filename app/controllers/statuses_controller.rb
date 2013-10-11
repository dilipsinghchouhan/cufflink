class StatusesController < ApplicationController
  def create
    @status = Status.new(params[:status])

    @status.user_id = params[:user_id] if params[:user_id]
    @status.company_id = params[:company_id] if params[:company_id]

    if @status.save & request.xhr?
      render partial: "show", locals: { object: @status }
    elsif @status.errors.full_messages.empty?
      flash[:notice] = "Status saved!"
      redirect_to :back
    else
      flash[:errors] = @status.errors.full_messages
      redirect_to :back
    end
  end

  def new
    @status = Status.new

    if request.xhr?
      p "request"
      render partial: "statuses/new", locals: { type: "user",
        object: current_user }
    else
      render :new
    end
  end
end
