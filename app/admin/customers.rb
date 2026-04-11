ActiveAdmin.register Customer do

  permit_params :user_name, :email, :name, :vendor_name, :telephone, :address

  # Remove password_digest from filters — not searchable for security reasons
  remove_filter :password_digest

end
