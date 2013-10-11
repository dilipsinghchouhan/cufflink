class EducationsController < ApplicationController
  def create
    @education = Education.new(clean_params_hash(params[:education]))
    @education.owner = current_user

    if @education.save & request.xhr?
      render partial: "show-and-edit", locals: { object: @education }

    elsif @education.errors.full_messages.empty?
      flash[:notice] = "Education created successfully."
      redirect_to user_url(current_user)

    elsif request.xhr?
      render json: @education.errors.full_messages, status: 422

    else
      flash[:errors] = @education.errors.full_messages
      redirect_to user_url(current_user)
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

    if request.xhr?
      render json: @education
    else
      flash[:notice] = "Education destroyed successfully"
      redirect_to
    end
  end

  def index
    if params[:term]
      schools = []
      @educations = []

      Education
        .find(:all, conditions: ['school LIKE ?', "#{params[:term]}%"])
        .each do |education|
          unless schools.include?(education.school)
            schools << education.school
            @educations << education
          end
        end

        @educations << Education.new(school: params[:term])
    else
      @educations = Education.all
    end

    respond_to do |format|
      format.json { render json: @educations.to_json }
    end
  end

  def new
    @education = Education.new

    if request.xhr?
      render partial: "educations/new", locals: { user: current_user,
         education: @education }
    else
      render :new
    end
  end

  private

  def current_education
    Education.find_by_id(params[:id])
  end
end
