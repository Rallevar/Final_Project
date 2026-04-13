=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-13
=end

ActiveAdmin.register Customer do

  permit_params :user_name, :email, :name, :telephone, :address

  # Keep encrypted password fields out of searchable admin filters.
  remove_filter :encrypted_password
  remove_filter :reset_password_token

end
