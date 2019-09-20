class CohortsController < ApplicationController
  before_action :authenticate_admin_user!

  def index
    if params[:instructor_id]
      @cohorts = Cohort.where(instructor_id: params[:instructor_id])
    elsif params[:all]
      @cohorts = Cohort.all
    else
      @cohorts = Cohort.where(instructor_id: current_user.id)
    end
    @cohorts = @cohorts.order(:created_at => :desc).includes(:users).order("users.last_name")
    if params[:limit]
      @cohorts = @cohorts[0..params[:limit].to_i]
    end
    @instructors = User.instructors
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
      flash.now[:success] = "Cohort updated."
      render :show
    else
      render :edit
    end
  end

  def grades
    cohort = Cohort.find(params[:cohort_id])
    @data = cohort.submissions_by_week
  end

  private

  def cohort_params
    params.require(:cohort).permit(:instructor_id, :location_id, :assignment_version_id, :nickname, :start_date, :gmail_calendar)
  end
end
