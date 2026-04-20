=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-13
=end

class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:products)
                          .order(:name)
                          .page(params[:page])
                          .per(15)
  end

  def show
    category = Category.find(params[:id])
    redirect_to products_path(category_id: category.id)
  end
end
