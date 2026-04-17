=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-13
=end

class OrdersController < ApplicationController
  def index
    cart = session[:cart] || {}
    product_ids = cart.keys.map(&:to_i)
    products = Product.includes(:category, image_attachment: :blob).where(id: product_ids)

    @cart_items = products.map do |product|
      quantity = cart[product.id.to_s].to_i

      {
        product: product,
        quantity: quantity,
        item_total: product.cost * quantity
      }
    end

    @cart_total = @cart_items.sum { |item| item[:item_total] }
  end

  def show
  end

  def add_item
    product = Product.find(params[:product_id])

    if product.stock_quantity.to_i <= 0
      redirect_back fallback_location: products_path, alert: "This product is out of stock."
      return
    end

    session[:cart] ||= {}
    product_key = product.id.to_s
    session[:cart][product_key] = session[:cart].fetch(product_key, 0).to_i + 1

    redirect_to orders_path, notice: "#{product.product_name.to_s.tr('-', ' ').titleize} was added to your cart."
  end

  def update_item
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if quantity < 1
      redirect_to orders_path, alert: "Quantity must be at least 1. Use Remove to delete an item from the cart."
      return
    end

    if quantity > product.stock_quantity.to_i
      redirect_to orders_path, alert: "Only #{product.stock_quantity} of this product are currently in stock."
      return
    end

    session[:cart] ||= {}
    session[:cart][product.id.to_s] = quantity

    redirect_to orders_path, notice: "Cart quantity was updated."
  end

  def remove_item
    session[:cart] ||= {}
    session[:cart].delete(params[:product_id].to_s)

    redirect_to orders_path, notice: "Item was removed from your cart."
  end
end
