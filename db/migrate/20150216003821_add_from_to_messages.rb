class AddFromToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :from, :string
  end
end
