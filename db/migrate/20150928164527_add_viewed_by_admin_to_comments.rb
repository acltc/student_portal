class AddViewedByAdminToComments < ActiveRecord::Migration
  def change
    add_column :comments, :viewed_by_admin, :boolean
  end
end
