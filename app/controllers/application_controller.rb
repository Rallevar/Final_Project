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
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :name, :telephone, :address, :province_code])
  end

  def map_customer_province_code
    customer_params = params[:customer]
    return if customer_params.nil?

    province_code = customer_params[:province_code]
    return if province_code.blank?

    province = Province.find_by(code: province_code)
    return if province.nil?

    customer_params[:province_id] = province.id
  end
end
