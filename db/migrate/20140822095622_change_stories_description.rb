class ChangeStoriesDescription < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :stories do |t|
        dir.up   { t.change :description, :text   }
        dir.down { t.change :description, :string }
      end
    end
  end
end
