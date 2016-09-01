module CohortHelper

  def viewed_by_admin_label_per_student(student)
    if student.submissions.any? || student.comments.any?
      get_css_label_cohort(student)
    end
  end

  def last_submission_or_comment(student)
    "Phase #{student.submissions.last.assignment.week}: #{student.submissions.last.assignment.title} (#{student.submissions.last.updated_at.strftime("%b %d")})"
  end

  def link_to_assignment(student)
    "/assignments/?student_id=#{student.id}"
  end

  private

  def get_css_label_cohort(student)
    if student.submissions.any? && student.submissions.where(viewed_by_admin: false).any?
      "danger"
    elsif student.comments.any? && student.comments.where(viewed_by_admin: false).any?
      "warning"
    else
      "success"
    end     
  end
end