require 'csv'

puts "Seeding database..."
puts "Clearing existing data..."
OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
Category.destroy_all
Customer.destroy_all
AboutPage.destroy_all

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

  # Build description by adding fields only if they have a real value
  description_parts = []

  if row['type'] != nil && row['type'] != "NA"
    description_parts << row['type']
  end

  if row['flavor'] != nil && row['flavor'] != "NA"
    description_parts << row['flavor']
  end

  if row['aroma'] != nil && row['aroma'] != "NA"
    description_parts << row['aroma']
  end

  if row['texture'] != nil && row['texture'] != "NA"
    description_parts << row['texture']
  end

  description = description_parts.join(' | ')

  # Set origin_country to nil if not listed
  origin_country = row['country']
  if origin_country == "NA"
    origin_country = nil
  end

  # Create the product if it doesn't already exist
  product = Product.find_or_create_by!(product_name: product_name) do |p|
    p.cost = 0
    p.stock_quantity = 0
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