=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-20
  Updated: 2026-04-20
=end

class CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end
end