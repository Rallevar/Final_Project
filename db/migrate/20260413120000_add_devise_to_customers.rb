class AddDeviseToCustomers < ActiveRecord::Migration[7.2]
  def change
    change_column_default :customers, :email, from: nil, to: ""

    add_column :customers, :encrypted_password, :string, null: false, default: ""
    add_column :customers, :reset_password_token, :string
    add_column :customers, :reset_password_sent_at, :datetime
    add_column :customers, :remember_created_at, :datetime

    add_index :customers, :email, unique: true
    add_index :customers, :reset_password_token, unique: true
  end
end
