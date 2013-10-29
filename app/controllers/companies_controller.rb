class CompaniesController < ApplicationController
  before_filter :require_logged_in_user

  def index
    @companies = Company.all
    render :index
  end

  def new
    @company = Company.new
    render :new
  end

  def create
    @company = Company.new(clean_params_hash(params[:company]))

    if @company.save
      flash[:notice] = "#{@company.name} has been created."
      @company.owner = current_user
      redirect_to company_url(@company)
    else
      flash[:errors] = clean_errors(@company)
      render :new
    end
  end

  def show
    @company = company_from_params
    @current_tab = params[:nav] ? params[:nav] : "main"
    
    render :show
  end

  def update
    @company = company_from_params

    if @company.update_attributes(params[:company])
      respond_to do |format|
        format.json { render json: @company }
        format.html {
          flash[:notice] = "Profile updated successfully!"
          redirect_to :back
        }
      end
    else
      respond_to do |format|
        format.json { render json: @company.errors.full_messages, status: 422 }
        format.html {
          flash[:errors] = @company.errors.full_messages
          redirect_to :back
        }
      end
    end
  end

  def destroy
    @company = company_from_params

    @company.destroy

    if request.xhr?
      render json: @company
    else
      redirect_to settings_url
    end
  end

  private

  def company_from_params
    Company.find_by_id(params[:id])
  end
end
