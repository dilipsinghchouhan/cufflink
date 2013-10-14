class ResponsesController < ApplicationController
  before_filter :require_logged_in_user

  def create
    @response = Response.new
    @status = Status.find_by_id(params[:status_id])

    @response.user, @response.status = current_user, @status

    @response.body = params[:response][:body] if params[:response]

    if @response.save && request.xhr?
        if @response.body
          render partial: "comment", locals: {comment: @response}
        else
          render partial: "responses/like-count", locals: {
            like_count: @status.like_count }
        end
    elsif request.xhr?
      render json: @response.errors.full_messages, status: 422
    elsif @response.errors.full_messages.empty?
      flash[:notice] = "Saved successfully!"
      redirect_to :back
    else
      flash[:errors] = @response.errors.full_messages
      redirect_to :back
    end

  end

end
