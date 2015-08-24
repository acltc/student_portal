class AddYouTubeIdToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :youtube_id, :string
  end
end
