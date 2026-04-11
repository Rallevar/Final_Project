ActiveAdmin.register Product do

  permit_params :product_name, :cost, :stock_quantity, :weight, :origin_country, :description, :category_id, :image

  # Active Storage image attachment cannot be filtered by Ransack
  remove_filter :image_attachment
  remove_filter :image_blob

  form do |f|
    f.inputs do
      f.input :product_name
      f.input :cost
      f.input :stock_quantity
      f.input :weight
      f.input :origin_country, as: :string
      f.input :description
      f.input :category
      f.input :image, as: :file
    end
    f.actions
  end

end
