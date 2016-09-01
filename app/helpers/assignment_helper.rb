module AssignmentHelper

  attr_accessor :unviewed_submission, :unviewed_commment, :viewed_both

  def get_css_classes_assignment_index(student, assignment)
    @unviewed_submission = "danger"
    @unviewed_comment = "warning"
    @viewed_both = "success"
    submission_or_comment?(student, assignment)
  end

  def get_css_classes_assignment_show(viewed_assignment, current_user, student, assignment)
    @unviewed_submission = "un-viewed-key"
    @unviewed_comment = "un-viewed-key-comment"
    @viewed_both = "viewed-key"
    css_class = ""
    css_class << "current-assignment " if assignment.id == viewed_assignment.id
    css_class << submission_or_comment?(student, assignment) if current_user.instructor_or_administrator
    css_class
  end

  private

  def submission_or_comment?(student, assignment)
    if student.submissions.where(assignment_id: assignment.id).any? || student.comments.where(assignment_id: assignment.id).any?
      get_css_label(student, assignment)
    else
      ""
    end
  end

  def get_css_label(student, assignment)
    if student.submissions.where(assignment_id: assignment.id).any? && student.submissions.where("assignment_id = ? AND viewed_by_admin = ?", assignment.id, false).any?
      return @unviewed_submission
    elsif student.comments.where(assignment_id: assignment.id).any? && student.comments.where("assignment_id = ? AND viewed_by_admin = ?", assignment.id, false).any?
      return @unviewed_comment
    else
      return @viewed_both
    end     
  end
  
end