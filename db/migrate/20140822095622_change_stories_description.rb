class ChangeStoriesDescription < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :stories do |t|
        dir.up   { t.change :description, :string }
        dir.down { t.change :description, :text   }
      end
    end
  end
end
