class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :email
      t.string :name
      t.string :vendor_name
      t.string :telephone
      t.string :address
      t.string :role

      t.timestamps
    end
  end
end
