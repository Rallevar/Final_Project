=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-13
=end

ActiveAdmin.register Customer do

  permit_params :user_name, :email, :name, :telephone, :address

  # Keep encrypted password fields out of searchable admin filters.
  remove_filter :encrypted_password
  remove_filter :reset_password_token

  scope :all
  # Default the admin view to customers who have submitted at least one order.
  scope("With Orders", default: true) do |customers|
    customer_ids = Order.all.pluck(:customer_id)
    customers.where(id: customer_ids)
  end

  controller do
    # Preload nested order data so the index page can render order details efficiently.
    def scoped_collection
      super.includes(orders: { order_items: :product })
    end
  end

  index title: "Customers and Order Details" do
    selectable_column
    id_column
    column :user_name
    column :email
    column :name
    column :telephone
    # Show each customer's orders inline so admins do not need to navigate elsewhere.
    column("Orders") do |customer|
      customer_orders = customer.orders.order(created_at: :desc)

      if customer_orders.any?
        ul do
          customer_orders.each do |order|
            li do
              # Basic order summary for quick scanning.
              div do
                order_date = ""

                if order.created_at.present?
                  order_date = order.created_at.strftime("%Y-%m-%d")
                end

                strong "Order ##{order.id}"

                if order_date.present?
                  span " - #{order_date}"
                end
              end

              div do
                span "Status: #{order.status.to_s.titleize}"
              end

              # List the products included in this order with their quantities.
              div do
                span "Products"
                ul do
                  order.order_items.each do |order_item|
                    li do
                      product_name = order_item.product.product_name.to_s
                      product_name = product_name.tr("-", " ")
                      product_name = product_name.titleize

                      span "#{product_name} x #{order_item.quantity}"
                    end
                  end
                end
              end

              # Combine all stored tax amounts so the admin sees one tax figure per order.
              div do
                total_tax = 0
                total_tax += order.gst_amount.to_d
                total_tax += order.pst_amount.to_d
                total_tax += order.hst_amount.to_d

                span "Taxes: #{helpers.number_to_currency(total_tax)}"
              end

              # Display the final recorded order total from checkout.
              div do
                span "Grand Total: #{helpers.number_to_currency(order.total_cost)}"
              end
            end
          end
        end
      else
        status_tag "No Orders"
      end
    end
    actions
  end

end
