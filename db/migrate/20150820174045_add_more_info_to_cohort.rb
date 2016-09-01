class AddMoreInfoToCohort < ActiveRecord::Migration
  def change
    remove_column :cohorts, :week_one_due_date, :date
    remove_column :cohorts, :week_two_due_date, :date
    remove_column :cohorts, :week_three_due_date, :date
    add_column :cohorts, :start_date, :date
    add_column :cohorts, :location_id, :integer
    add_column :cohorts, :nickname, :string
  end
end
