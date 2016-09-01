class CreateAssignmentVersions < ActiveRecord::Migration
  def change
    create_table :assignment_versions do |t|
      t.text :description

      t.timestamps null: false
    end
  end
end
