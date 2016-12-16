class AddOrderToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :assignment_order, :integer
    Cohort.all.each do |cohort|
      cohort.assignment_version.assignments.each do |assignment|
        update = assignment.update(assignment_order: assignment.id)
        p update
      end
    end
  end
end
