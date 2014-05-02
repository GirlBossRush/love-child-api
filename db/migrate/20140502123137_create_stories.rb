class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :description
      t.string :body

      t.timestamps
    end
  end
end
