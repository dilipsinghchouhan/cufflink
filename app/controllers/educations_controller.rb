class EducationsController < ApplicationController
  def create
    @education = Education.new(clean_params_hash(params[:education]))
    @education.owner_id = params[:user_id]

    if @education.save
      render json: @education
    else
      render json: @education.errors.full_messages, status: 422
    end
  end

  def update
    @education = current_education

    if @education.update_attributes(params[:education])
      render json: @education
    else
      render json: @education.errors.full_messages, status: 422
    end
  end

  def destroy
    @education = current_education

    @education.destroy

    render json: ""
  end

  private

  def current_education
    Education.find_by_id(params[:id])
  end
end
