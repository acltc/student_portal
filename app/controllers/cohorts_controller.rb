class CohortsController < ApplicationController
  before_action :authenticate_admin_user!
  
  def index
    if params[:instructor_id]
      @cohorts = Cohort.where(instructor_id: params[:instructor_id]).includes(:users).order("users.last_name")
    else
      @cohorts = Cohort.all.includes(:users).order("users.last_name")
    end
    @instructors = User.where(role_id: 2)
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
    if params[:cohort_id]
      cohort = Cohort.find(params[:cohort_id])
    else
      if params[:instructor_id]
        instructor_id = params[:instructor_id]
      else
        instructor_id = current_user.id
      end
      cohort = Cohort.where(instructor_id: instructor_id).last
    end

    @student_names = cohort.student_names_for_table
    @start_date = cohort.start_date
    @grades = cohort.grades_for_table
    @submissions = cohort.submissions_for_table
    @assignments = Assignment.all
  end

  private

  def cohort_params
    params.require(:cohort).permit(:instructor_id, :location_id, :assignment_version_id, :nickname, :start_date, :gmail_calendar)
  end



end
