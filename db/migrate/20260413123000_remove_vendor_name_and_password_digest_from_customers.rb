class RemoveVendorNameAndPasswordDigestFromCustomers < ActiveRecord::Migration[7.2]
  def change
    remove_column :customers, :vendor_name, :string
    remove_column :customers, :password_digest, :string
  end
end
