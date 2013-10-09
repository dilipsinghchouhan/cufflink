class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    render :index
  end

  def new
    @company = Company.new
    render :new
  end

  def create
    user_params = {}

    params[:company].each do |key, value|
      if value == ""
        user_params[key] = nil
      else
        user_params[key] = value
      end
    end

    @company = Company.new(user_params)

    if @company.save
      flash[:notice] = "Company created successfully!"
      @company.owner = current_user
      redirect_to company_url(@company)
    else
      flash[:errors] = @company.errors.full_messages
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
