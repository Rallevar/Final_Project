=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-19
=end

class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
    load_cart
  end

  def show
    @order = current_customer.orders.includes(order_items: :product).find(params[:id])
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

  def checkout
    load_cart

    if @cart_items.empty?
      redirect_to orders_path, alert: "Your cart is empty."
      return
    end

    @provinces = Province.order(:name)
    @selected_province = selected_province_for_checkout
    @shipping_address = current_customer.address
    calculate_checkout_totals(@selected_province)
  end

  def place_order
    load_cart

    if @cart_items.empty?
      redirect_to orders_path, alert: "Your cart is empty."
      return
    end

    province = Province.find_by(id: params[:province_id]) || current_customer.province
    shipping_address = params[:shipping_address].presence || current_customer.address

    if province.nil?
      redirect_to checkout_orders_path, alert: "Please select a province before placing your order."
      return
    end

    if shipping_address.blank?
      redirect_to checkout_orders_path, alert: "Please provide a shipping address before placing your order."
      return
    end

    calculate_checkout_totals(province)

    out_of_stock_item = @cart_items.find do |item|
      item[:quantity] > item[:product].stock_quantity.to_i
    end

    if out_of_stock_item
      redirect_to checkout_orders_path, alert: "One or more items do not have enough stock to complete this order."
      return
    end

    order = nil
    ActiveRecord::Base.transaction do
      order = current_customer.orders.create!(
        status: "new",
        shipping_address: shipping_address,
        province_name: province.name,
        subtotal: @subtotal,
        gst_rate: province.gst_rate,
        pst_rate: province.pst_rate,
        hst_rate: province.hst_rate,
        gst_amount: @gst_amount,
        pst_amount: @pst_amount,
        hst_amount: @hst_amount,
        total_cost: @grand_total
      )

      @cart_items.each do |item|
        product = item[:product]
        quantity = item[:quantity]

        order.order_items.create!(
          product: product,
          quantity: quantity,
          unit_price: product.cost,
          total_price: item[:item_total]
        )

        product.update!(stock_quantity: product.stock_quantity - quantity)
      end

      current_customer.update!(address: shipping_address, province: province)
      session[:cart] = {}
    end

    redirect_to order_path(order), notice: "Your order has been placed successfully."
  end

  private

  def load_cart
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

  def selected_province_for_checkout
    if params[:province_id].present?
      Province.find_by(id: params[:province_id])
    else
      current_customer.province
    end
  end

  def calculate_checkout_totals(province)
    @subtotal = @cart_total

    if province.nil?
      @gst_amount = 0
      @pst_amount = 0
      @hst_amount = 0
      @grand_total = @subtotal
      return
    end

    @gst_amount = @subtotal * province.gst_rate.to_d
    @pst_amount = @subtotal * province.pst_rate.to_d
    @hst_amount = @subtotal * province.hst_rate.to_d
    @grand_total = @subtotal + @gst_amount + @pst_amount + @hst_amount
  end
end
