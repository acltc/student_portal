class AddSolutionToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :solution, :string
  end
end
