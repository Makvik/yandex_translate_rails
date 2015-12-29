class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.integer :role

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
