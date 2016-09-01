class ChangeClassGroupToCohort < ActiveRecord::Migration
  def change
    rename_table :class_groups, :cohorts
  end
end
