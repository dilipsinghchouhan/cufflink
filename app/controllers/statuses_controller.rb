class StatusesController < ApplicationController
  def create
    @status = Status.new(params[:status])

    @status.user_id = params[:user_id] if params[:user_id]
    @status.company_id = params[:company_id] if params[:company_id]

    if @status.save
      flash[:notice] = "Status saved!"
      redirect_to :back
    else
      flash[:errors] = @status.errors.full_messages
      redirect_to :back
    end
  end
end
