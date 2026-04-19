ActiveAdmin.register Order do
  permit_params :customer_id,
                :status,
                :total_cost,
                :shipping_address,
                :province_name,
                :subtotal,
                :gst_rate,
                :pst_rate,
                :hst_rate,
                :gst_amount,
                :pst_amount,
                :hst_amount

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :customer_id, :status, :total_cost
  #
  # or
  #
  # permit_params do
  #   permitted = [:customer_id, :status, :total_cost]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
