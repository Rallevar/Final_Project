class RemoveUserNameFromCustomers < ActiveRecord::Migration[7.2]
  def up
    if column_exists?(:customers, :user_name)
      remove_column :customers, :user_name
    end
  end

  def down
    unless column_exists?(:customers, :user_name)
      add_column :customers, :user_name, :string
    end
  end
end
