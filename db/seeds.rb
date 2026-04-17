=begin
  Name: Nathan Keenan
  Program: Business Information Technology
  Course: WEBD-3011 (277098)
  Created: 2026-04-10
  Updated: 2026-04-13
=end

require 'csv'
require 'faker'

puts "Seeding database..."
puts "Clearing existing data..."
OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
Category.destroy_all
Customer.destroy_all
Province.destroy_all
AboutPage.destroy_all

puts "Creating provinces..."
provinces = [
  { name: "Alberta", code: "AB", gst_rate: 0.05, pst_rate: 0.0, hst_rate: 0.0 },
  { name: "British Columbia", code: "BC", gst_rate: 0.05, pst_rate: 0.07, hst_rate: 0.0 },
  { name: "Manitoba", code: "MB", gst_rate: 0.05, pst_rate: 0.07, hst_rate: 0.0 },
  { name: "New Brunswick", code: "NB", gst_rate: 0.0, pst_rate: 0.0, hst_rate: 0.15 },
  { name: "Newfoundland and Labrador", code: "NL", gst_rate: 0.0, pst_rate: 0.0, hst_rate: 0.15 },
  { name: "Northwest Territories", code: "NT", gst_rate: 0.05, pst_rate: 0.0, hst_rate: 0.0 },
  { name: "Nova Scotia", code: "NS", gst_rate: 0.0, pst_rate: 0.0, hst_rate: 0.15 },
  { name: "Nunavut", code: "NU", gst_rate: 0.05, pst_rate: 0.0, hst_rate: 0.0 },
  { name: "Ontario", code: "ON", gst_rate: 0.0, pst_rate: 0.0, hst_rate: 0.13 },
  { name: "Prince Edward Island", code: "PE", gst_rate: 0.0, pst_rate: 0.0, hst_rate: 0.15 },
  { name: "Quebec", code: "QC", gst_rate: 0.05, pst_rate: 0.09975, hst_rate: 0.0 },
  { name: "Saskatchewan", code: "SK", gst_rate: 0.05, pst_rate: 0.06, hst_rate: 0.0 },
  { name: "Yukon", code: "YT", gst_rate: 0.05, pst_rate: 0.0, hst_rate: 0.0 }
]

provinces.each do |province_data|
  Province.create!(province_data)
end

puts "Reading data from CSV..."
csv_path = Rails.root.join('db', 'cheese_details.csv')

puts "Creating categories and products..."
CSV.foreach(csv_path, headers: true) do |row|
  family = row['family']

  # Skip this row if family is missing or not listed. Family will be used as the category.
  if family == nil || family == "NA" || family == ""
    next
  end

  # Create the category if it doesn't already exist
  category = Category.find_or_create_by!(name: family)

  # Pull the product name from the end of the URL
  url_parts = row['url'].split('/')
  product_name = url_parts[url_parts.length - 1]

  # Skip if we couldn't get a name
  if product_name == nil || product_name == ""
    next
  end

  # Build a readable name and sentence-style description.
  display_name = product_name.tr('-', ' ').titleize

  cheese_type = row['type']
  if cheese_type == nil || cheese_type == "NA" || cheese_type == ""
    cheese_type = "traditional"
  end

  flavor = row['flavor']
  if flavor == nil || flavor == "NA" || flavor == ""
    flavor = "balanced flavor profile"
  end

  aroma = row['aroma']
  if aroma == nil || aroma == "NA" || aroma == ""
    aroma = "mild"
  end

  texture = row['texture']
  if texture == nil || texture == "NA" || texture == ""
    texture = "smooth"
  end

  # Set origin_country to nil if not listed
  origin_country = row['country']
  if origin_country == nil || origin_country == "NA" || origin_country == ""
    origin_country = nil
  end

  origin_text = origin_country
  if origin_text == nil
    origin_text = "an unknown region"
  end

  description = display_name + " is a " + cheese_type + " cheese hailing from " + origin_text + ". " +
                display_name + " boasts a " + flavor + " flavor profile and a " + aroma + " aroma. " +
                display_name + " is most known to be a " + texture + " cheese."

  # Create the product if it doesn't already exist
  Product.find_or_create_by!(product_name: product_name) do |p|
    p.cost = Faker::Commerce.price(range: 1.0..50.0)
    p.stock_quantity = Faker::Number.between(from: 0, to: 40)
    p.weight = 0
    p.origin_country = origin_country
    p.description = description
    p.category = category
  end
end

puts "Seeded " + Category.count.to_s + " categories and " + Product.count.to_s + " products."

puts "Creating admin user..."
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?



# Create a default About page record if one does not exist yet.
about_page = AboutPage.first

if about_page == nil
  AboutPage.create!(
    title: "About Us",
    content: "Welcome to Winnipeg Cheesemongers. You can edit this content in your Active Admin dashboard.",
    telephone: "204-555-1234",
    address: "123 Cheese Lane, Winnipeg, MB",
    email: "info@winnipegcheesemongers.com"
  )
end

puts "Database seeding complete."