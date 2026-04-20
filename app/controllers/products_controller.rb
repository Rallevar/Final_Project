=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-13
=end

class ProductsController < ApplicationController
  before_action :load_categories, only: [:index, :recent, :newest]

  def index
    @products = Product.includes(:category, image_attachment: :blob)
                       .order(product_name: :asc)

    # Keyword search
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @products = @products.where(
        "product_name LIKE ? OR description LIKE ?",
        keyword, keyword
      )
    end

    # Category filter
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    # Pagination
    @products = @products.page(params[:page]).per(30)
  end

  def show
    @product = Product.includes(:category, image_attachment: :blob).find(params[:id])
  end

  def recent
    # Recent products were created earlier, but updated within the last 3 days.
    @products = Product.includes(:category, image_attachment: :blob)
                       .where("updated_at >= ?", 3.days.ago)
                       .where("created_at < ?", 3.days.ago)
                       .order(updated_at: :desc)
                       .page(params[:page])
                       .per(30)

    render :index
  end

  def newest
    # Newest products were created within the last 3 days.
    @products = Product.includes(:category, image_attachment: :blob)
                       .where("created_at >= ?", 3.days.ago)
                       .order(created_at: :desc)
                       .page(params[:page])
                       .per(30)

    render :index
  end

  private

  def load_categories
    @categories = Category.order(:name)
  end
end
