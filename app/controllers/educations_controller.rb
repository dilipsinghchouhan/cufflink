class EducationsController < ApplicationController
  def create
    @education = Education.new(clean_params_hash(params[:education]))
    @education.owner = current_user

    @education.position = true if params[:position]

    if @education.save 
      if request.xhr?
        render partial: "show-and-edit", locals: { object: @education }
      else
        flash[:notice] = "Education created successfully."
        redirect_to user_url(current_user)
      end
      
      company_followup(@education) if params[:position]
      
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
    if params[:position]
      p "we have a psotion"
    else
      p "we dont have a position"
    end
    
    true_or_false = params[:position] ? "TRUE" : "FALSE"
    condition = "position IS " + true_or_false + " AND "

    if params[:term]
      schools = []
      @educations = []

      Education.find(:all, conditions: [
          condition + 'school LIKE ?', "#{params[:term]}%"])
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
         education: @education, position: params[:position] }
    else
      render :new
      #how do i make this change? if theres a pos?
    end
  end

  private

  def current_education
    Education.find_by_id(params[:id])
  end
  
  def company_followup(company)
    existing_company = Company.find_by_name(company.school)
    
    company_id = existing_company.id if existing_company
      
    unless existing_company
      new_company = Company.create(name: company.school, industry: "Other")
      company_id = new_company.id 
    end
    
    Membership.create(
      company_id: company_id,
      member_id: current_user.id
    )
  end
end
