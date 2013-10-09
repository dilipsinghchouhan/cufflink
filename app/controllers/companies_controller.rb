class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    render :index
  end

  def show
    @company = Company.find_by_id(params[:id])
    render :show
  end
end
