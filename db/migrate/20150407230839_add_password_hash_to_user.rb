class AddPasswordHashToUser < ActiveRecord::Migration
  def change
    add_column :users, :string, :password_hash
  end
end
