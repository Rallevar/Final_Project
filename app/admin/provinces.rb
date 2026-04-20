=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-19
  Updated: 2026-04-19
=end

ActiveAdmin.register Province do
  permit_params :name, :code, :gst_rate, :pst_rate, :hst_rate

  actions :index, :show, :edit, :update

  # Provinces and territories are already seeded, so this page is for rate maintenance only.
  config.sort_order = "name_asc"

  index title: "Province Tax Rates" do
    id_column
    column :name
    column :code
    column("GST") do |province|
      province.gst_rate
    end
    column("PST") do |province|
      province.pst_rate
    end
    column("HST") do |province|
      province.hst_rate
    end
    column :updated_at
    actions
  end

  # Show the saved rates for one province or territory in a simple read-only view.
  show do
    attributes_table do
      row :id
      row :name
      row :code
      row :gst_rate
      row :pst_rate
      row :hst_rate
      row :created_at
      row :updated_at
    end
  end

  # Allow the admin to update tax rates without changing the seeded province list.
  form do |f|
    f.inputs do
      f.input :name, input_html: { readonly: true }
      f.input :code, input_html: { readonly: true }
      f.input :gst_rate
      f.input :pst_rate
      f.input :hst_rate
    end
    f.actions
  end
end