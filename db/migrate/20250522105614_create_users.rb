class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :first_name
      t.string :last_name
      t.boolean :email_confirmed, default: false
      t.string :confirmation_token
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :last_login

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
