class MembershipsController < ApplicationController
  before_filter :require_logged_in_user

  def create
    @membership = Membership.new

    @membership.company_id = params[:company_id]
    @membership.member = current_user

    if @membership.save
      flash[:notice] = "Successfully joined company!"
      redirect_to :back
    else
      flash[:errors] = @membership.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @membership = Membership.find_by_id(params[:id])

    flash[:notice] = "Successfully left company!"

    @membership.destroy

    redirect_to :back
  end
end
