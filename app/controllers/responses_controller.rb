class ResponsesController < ApplicationController
  def create
    @response = Response.new

    @response.user = current_user
    @response.status_id = params[:status_id]

    @response.body = params[:response][:body] if params[:response]

    if @response.save
      if @response.body
        flash[:notice] = "Comment succesfully saved!"
      else
        flash[:notice] = "Like successfully saved!"
      end
    else
      flash[:errors] = @response.errors.full_messages
    end

    redirect_to :back
  end
end
