module AdminView

  def reverse_admin_views(view_boolean)
    assignments = self.class.where("user_id = ? AND assignment_id = ?", user_id, assignment_id)
    if assignments.update_all(viewed_by_admin: view_boolean)
      return assignments.last
    end
  end

end