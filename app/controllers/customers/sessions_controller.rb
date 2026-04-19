=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-19
  Updated: 2026-04-19
=end

class Customers::SessionsController < Devise::SessionsController
  def new
    super do
      return render :login
    end
  end
end