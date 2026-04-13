class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category, image_attachment: :blob)
                       .order(product_name: :asc)
                       .limit(30)
  end

  def show
  end
end
