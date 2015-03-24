class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## User Info
      t.string :name
      t.string :email

      # Phone number and verifications
      t.string :phone_number
      t.string :verification_code
      t.boolean :phone_verified, :default => false

      ## Tokens
      t.text :tokens

      t.timestamps
    end
  end
end
