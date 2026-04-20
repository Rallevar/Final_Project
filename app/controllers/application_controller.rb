=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-19
=end

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :map_customer_province_code, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :name, :telephone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :name, :telephone, :address, :province_id])
  end

  def map_customer_province_code
    customer_params = params[:customer]
    return if customer_params.nil? || !customer_params.key?(:province_code)

    if customer_params[:province_code].blank?
      customer_params[:province_id] = nil
      customer_params.delete(:province_code)
      return
    end

    province_code = customer_params[:province_code]

    province = Province.find_by(code: province_code)
    if province.nil?
      customer_params.delete(:province_code)
      return
    end

    customer_params[:province_id] = province.id
    customer_params.delete(:province_code)
  end
end
