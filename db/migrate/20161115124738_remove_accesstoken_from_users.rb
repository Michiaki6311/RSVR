class RemoveAccesstokenFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :access_token
  end
end
