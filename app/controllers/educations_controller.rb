class EducationsController < ApplicationController
  def create

  end

  def update

  end

  def destroy
    @user, @education = current_user_and_education

    @education.destroy

    flash[:notice] = "School successfully deleted."

    redirect_to user_url(@user)
  end

  private

  def current_user_and_education
    @user = User.find_by_id(params[:user_id])
    @education = Education.find_by_id(params[:id])

    [@user, @education]
  end
end
