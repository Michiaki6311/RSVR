class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.integer :reserves_count
      t.string :password_digest
      t.string :access_token, :null => false, :limit => 6

      t.timestamps
    end
    add_index :users, :access_token, :unique => true
  end
end
