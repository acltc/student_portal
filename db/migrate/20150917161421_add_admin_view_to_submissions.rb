class AddAdminViewToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :viewed_by_admin, :boolean
  end
end
