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
    @product = Product.includes(:category, image_attachment: :blob).find(params[:id])
  end

  def recent
    @products = Product.where("updated_at >= ?", 3.days.ago) && Product.where("created_at != updated_at")
                              .order(updated_at: :desc)
                              .limit(30)

    render :index
  end

  def newest
    @products = Product.where("created_at >= ?", 3.days.ago)
                          .order(created_at: :desc)
                          .limit(30)

    render :index
  end
end
