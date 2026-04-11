class RemoveRoleFromCustomers < ActiveRecord::Migration[7.2]
  def change
    remove_column :customers, :role, :string
  end
end
