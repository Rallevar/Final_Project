class AddContactFieldsToAboutPages < ActiveRecord::Migration[7.2]
  def change
    add_column :about_pages, :telephone, :string
    add_column :about_pages, :address, :string
    add_column :about_pages, :email, :string
  end
end