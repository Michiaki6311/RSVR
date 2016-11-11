class CreateUserInterimRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :user_interim_registrations do |t|
      t.string :email
      t.string :access_token, :null => false, :limit => 6

      t.timestamps
    end
    add_index :user_interim_registrations, :access_token, :unique => true
  end
end
