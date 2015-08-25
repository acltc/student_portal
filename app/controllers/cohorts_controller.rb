class CohortsController < ApplicationController
  before_action :authenticate_admin_user!
  
  def index
    if params[:instructor_id]
      @cohorts = Cohort.where(instructor_id: params[:instructor_id])
    else
      @cohorts = Cohort.all.includes(:users)
    end
  end

  def new
    @cohort = Cohort.new
  end

  def create
    @cohort = Cohort.new(cohort_params)
    if @cohort.save
      render :show
    else
    end
  end

  def show
    @cohort = Cohort.find(params[:id])
  end

  def edit
    @cohort = Cohort.find(params[:id])
  end

  def update
    @cohort = Cohort.find(params[:id])
    if @cohort.update(cohort_params)
      flash[:success] = "Cohort updated."
      render :show
    else
    end
  end

  private

  def cohort_params
    params.require(:cohort).permit(:instructor_id, :location_id, :nickname, :start_date)
  end



end
