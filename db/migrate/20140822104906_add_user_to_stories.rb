class AddUserToStories < ActiveRecord::Migration
  def change
    add_column :stories, :user_id, :uuid
  end
end
