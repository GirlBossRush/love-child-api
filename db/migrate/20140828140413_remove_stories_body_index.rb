class RemoveStoriesBodyIndex < ActiveRecord::Migration
  def up
    remove_index :stories, :body
  end

  def down
    add_index :stories, :body
  end
end
