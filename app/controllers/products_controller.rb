=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-13
=end

class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category, image_attachment: :blob)
                       .order(product_name: :asc)
                       .limit(30)
  end

  def show
  end
end
