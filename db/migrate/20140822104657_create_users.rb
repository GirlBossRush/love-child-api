class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, unqiue: true
      t.text :description
      t.string :password_digest
      t.string :role
      t.string :email, unqiue: true
      t.datetime :last_login
      t.datetime :last_activity

      t.timestamps
    end

    add_index :users, :name
    add_index :users, :role
    add_index :users, :email
    add_index :users, :created_at
  end
end
