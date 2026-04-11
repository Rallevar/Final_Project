class RenameUsersToCustomers < ActiveRecord::Migration[7.2]
  def change
    rename_table :users, :customers
    rename_column :orders, :user_id, :customer_id
  end
end
