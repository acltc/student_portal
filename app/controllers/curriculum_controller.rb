class CurriculumController < ApplicationController
  before_action :authenticate_admin_user!, only: [:select_cohort]

  def index
    @cohort = current_user.student ? current_user.cohort : Cohort.last
    @cohorts = Cohort.all if current_user.instructor_or_administrator
  end

  def select_cohort
    @cohort = Cohort.find(params[:post][:cohort_id])
    @cohorts = Cohort.all
    render :index
  end

end
