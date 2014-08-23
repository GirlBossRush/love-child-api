class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories, id: :uuid do |t|
      t.string :title
      t.text :description
      t.text :body

      t.timestamps
    end

    add_index :stories, :title
    add_index :stories, :description
    add_index :stories, :body
    add_index :stories, :created_at
  end
end
