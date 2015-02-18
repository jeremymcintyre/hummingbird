class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :user
      t.string :to # example "+15558675309"
      t.string :body
      t.datetime :send_at_datetime

      t.timestamps null: false
    end
  end
end
