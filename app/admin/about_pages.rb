=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-13
=end

ActiveAdmin.register AboutPage do
  permit_params :title, :content, :telephone, :address, :email

  actions :index, :show, :edit, :update

  index do
    id_column
    column :title
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :content
      f.input :telephone
      f.input :address
      f.input :email
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :content do |about_page|
        simple_format(about_page.content)
      end
      row :telephone
      row :address
      row :email
      row :created_at
      row :updated_at
    end
  end
end