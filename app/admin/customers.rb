ActiveAdmin.register Customer do

  permit_params :user_name, :email, :name, :telephone, :address

  # Keep encrypted password fields out of searchable admin filters.
  remove_filter :encrypted_password
  remove_filter :reset_password_token

end
