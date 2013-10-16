class CompaniesController < ApplicationController
  before_filter :require_logged_in_user, except: [:index, :show]

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
    render :show
  end

  def update
    @company = company_from_params

    if @company.update_attributes(params[:company])
      render json: @company
    else
      render json: @company.errors.full_messages, status: 422
    end
  end

  private

  def company_from_params
    Company.find_by_id(params[:id])
  end
end
