class Submission < ActiveRecord::Base
  include AdminView

  mount_uploader :solution, SolutionUploader
  belongs_to :assignment
  belongs_to :user
  has_many :comments

  def grade
    assignment.grades.find_by(user_id: user_id)
  end

  def table_style(column_num, cohort_start, week_num)
    week_start = cohort_start + (7 * (week_num - 1)).days

    if created_at > week_start + 8.days
      message = "grade-table-late"
    elsif created_at > week_start + 6.days
      message = "grade-table-waited-for-weekend"
    else
      message = "grade-table-submitted"
    end

    if column_num.even?
      message += "-even"
    end

    message
  end

end
