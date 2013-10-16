class ExperiencesController < ApplicationController
  before_filter :require_logged_in_user

  def create
    @experience = Experience.new(clean_params_hash(params[:experience]))
    @experience.owner = current_user

    @experience.position = true if params[:position]

    if @experience.save
      if request.xhr?
        render partial: "show-and-edit", locals:
          { object: @experience, klass: "two-thirds" }
      else
        flash[:notice] = "Experience created successfully."
        redirect_to user_url(current_user)
      end

      # company_followup(@experience) if params[:position]

    elsif request.xhr?
      render json: @experience.errors.full_messages, status: 422

    else
      flash[:errors] = @experience.errors.full_messages
      redirect_to user_url(current_user)
    end
  end

  def update
    @experience = current_experience

    if @experience.update_attributes(params[:experience])
      render json: @experience
    else
      render json: @experience.errors.full_messages, status: 422
    end
  end

  def destroy
    @experience = current_experience

    @experience.destroy

    if request.xhr?
      render json: @experience
    else
      flash[:notice] = "Experience destroyed successfully"
      redirect_to
    end
  end

  def index
    true_or_false = params[:position] ? "TRUE" : "FALSE"
    condition = "position IS " + true_or_false + " AND "

    if params[:term]
      names = []
      @experiences = []

      array = Experience.find(:all, conditions:
        [condition + 'name LIKE ?', "%#{params[:term]}%"])
      array += Company.find(:all, conditions:
        ['name LIKE ?', "%#{params[:term]}%"])

      array.each do |experience|
        unless names.include?(experience.name)
          names << experience.name
          @experiences << experience
        end
      end

      @experiences << Experience.new(name: params[:term])
    else
      @experiences = Experience.all
    end

    respond_to do |format|
      format.json { render json: @experiences.to_json }
    end
  end

  def new
    @experience = Experience.new

    if request.xhr?
      render partial: "experiences/new", locals: { user: current_user,
         experience: @experience, position: params[:position] }
    else
      render :new
      #how do i make this change? if theres a pos?
    end
  end

  private

  def current_experience
    Experience.find_by_id(params[:id])
  end
end
