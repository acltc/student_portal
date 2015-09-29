module AdminView

  def reverse_admin_views(instance_variable, view_boolean)
    assignments = instance_variable.class.name.constantize.where("user_id = ? AND assignment_id = ?", instance_variable.user_id, instance_variable.assignment_id)
    if assignments.update_all(viewed_by_admin: view_boolean)
      return assignments.last
    end
  end

end