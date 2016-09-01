class AddAttachmentToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :attachment, :boolean
  end
end
