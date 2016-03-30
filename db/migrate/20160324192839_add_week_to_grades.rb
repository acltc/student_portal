class AddWeekToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :week, :integer
  end
end
