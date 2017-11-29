class CohortsController < ApplicationController
  before_action :authenticate_admin_user!
  
  def index
    if params[:instructor_id]
      @cohorts = Cohort.where(instructor_id: params[:instructor_id]).order(:created_at => :desc).includes(:users).order("users.last_name")
    elsif params[:all]
      @cohorts = Cohort.all.order(:created_at => :desc).includes(:users).order("users.last_name")
    else
      @cohorts = Cohort.where(instructor_id: current_user.id).order(:created_at => :desc).includes(:users).order("users.last_name")
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
    @student_names = cohort.student_names_for_table
    @start_date = cohort.start_date
    @grades = cohort.grades_for_table
    @submissions = cohort.submissions_for_table
    @assignments = cohort.assignment_version.assignments
  end

  private

  def cohort_params
    params.require(:cohort).permit(:instructor_id, :location_id, :assignment_version_id, :nickname, :start_date, :gmail_calendar)
  end



end
