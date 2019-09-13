class Cohort < ActiveRecord::Base
  has_many :users
  belongs_to :assignment_version
  belongs_to :instructor, foreign_key: 'instructor_id', class_name: "User"
  belongs_to :location
  has_many :grades, through: :users
  has_many :submissions, through: :users

  validates :start_date, presence: true
  validates_associated :location, :assignment_version

  def all_attributes
    "Start Date: #{start_date} Instructor: #{instructor.full_name} Location: #{location.name}"
  end

  def submissions_by_week
    assignments_by_week = assignment_version.assignments
      .includes(:submissions)
      .order(:assignment_order)
      .group_by(&:week)
    grades = Grade.where(user_id: users.pluck(:id))
    data = {}
    assignments_by_week.each do |week, assignments|
      data[week] = {
        assignments: assignments,
        students: []
      }
      users.order(:last_name).each do |user|
        data[week][:students].push({
          id: user.id,
          name: "#{user.first_name} #{user.last_name[0]}",
          assignments: assignments.map { |assignment|
            submission = assignment.submissions.select { |x| x.user_id == user.id }[0]
            grade = submission ? grades.select { |x| x.user_id == user.id && x.assignment_id == assignment.id }[0] : nil
            submission_style = submission ? submission.table_style(assignment.id, start_date, week) : assignment.table_style
            grade_style = grade ? grade.table_style : ""
            {
              id: assignment.id,
              assignment: assignment,
              submission: submission,
              grade: grade,
              submission_style: submission_style,
              grade_style: grade_style
            }
          }
        })
      end
    end
    data
  end

  def students
    users.where(role_id: 3)
  end

  def next_submission_to_assess

    submissions_holder = self.submissions.order(:assignment_id,:user_id).to_a
    grades_holder = self.grades

    submissions_holder.delete_if do |submission|
      grades_holder.any? do |grade|
        submission.assignment_id == grade.assignment_id && submission.user_id == grade.user_id
      end
    end

    submissions_holder.first
  end
end
