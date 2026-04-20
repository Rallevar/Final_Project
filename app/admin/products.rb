=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-13
=end

ActiveAdmin.register Product do

  permit_params :product_name, :cost, :stock_quantity, :weight, :origin_country, :description, :category_id, :image

  # Active Storage image attachment cannot be filtered by Ransack
  remove_filter :image_attachment
  remove_filter :image_blob

  index do
    selectable_column
    id_column
    column :product_name
    column :category
    column :cost
    column :stock_quantity
    column("Image") do |product|
      if product.image.attached?
        image_tag product.image, style: "width: 80px; height: 80px; object-fit: cover;"
      else
        "No image"
      end
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :product_name
      row :category
      row :cost
      row :stock_quantity
      row :weight
      row :origin_country
      row :description
      row("Image") do |product|
        if product.image.attached?
          image_tag product.image, style: "max-width: 250px; height: auto;"
        else
          "No image uploaded"
        end
      end
      row :created_at
      row :updated_at
    end
  end


  form do |f|
    f.inputs do
      f.input :product_name
      f.input :cost
      f.input :stock_quantity
      f.input :weight
      f.input :origin_country, as: :string
      f.input :description
      f.input :category
      if f.object.image.attached?
        f.input :image, as: :file, hint: image_tag(f.object.image, style: "max-width: 150px; height: auto;")
      else
        f.input :image, as: :file
      end
    end
    f.actions
  end
end
