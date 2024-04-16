

puts 'Cleaning database...'

# Clear dependent records (reverse order based on dependencies)
puts 'Cleaning database...'
Category.destroy_all
Membership.destroy_all
TopUp.destroy_all
Order.destroy_all
User.destroy_all
Admin.destroy_all  # Clear admin records as well

puts 'Creating categories...'
short = Category.create!(name: 'short')
long = Category.create!(name: 'long')

puts 'Creating users...'
user1 = User.create!(username: 'user1', email: 'user1@example.com', password: 'password1')
user2 = User.create!(username: 'user2', email: 'user2@example.com', password: 'password2')

puts 'Creating admins...'
admin1 = Admin.create!(email: 'admin1@example.com', password: 'admin_password1', admin_name: 'Admin User 1')
admin2 = Admin.create!(email: 'admin2@example.com', password: 'admin_password2', admin_name: 'Admin User 2')

puts 'Creating memberships...'
Membership.create!(
  sku: 'daily',
  name: 'Daily Drop In',
  category: short,
  price_cents: 180000,
  photo_url: 'http://onehdwallpaper.com/wp-content/uploads/2015/07/Teddy-Bears-HD-Images.jpg',
  days_of_membership: 1,
  user_id: nil,
  membership_days_remaining: 0
)
Membership.create!(sku: 'monthly', name: 'Monthly', category: long, price_cents: 1200000, photo_url: 'https://pbs.twimg.com/media/B_AUcKeU4AE6ZcG.jpg:large',days_of_membership: 30,
user_id: nil,
membership_days_remaining: 0)
Membership.create!(sku: 'yearly', name: 'Yearly', category: long, price_cents: 90000000, photo_url: 'https://cdn-ak.f.st-hatena.com/images/fotolife/s/suzumidokoro/20160413/20160413220730.jpg',days_of_membership: 365,
user_id: nil,
membership_days_remaining: 0)

puts 'Creating top-ups...'
TopUp.create!(
  state: 'pending',
  amount_cents: 500000,  # Amount in cents
  amount_currency: 'IDR', # Currency code
  user: user1
)

TopUp.create!(
  state: 'pending',
  amount_cents: 1000000, # Amount in cents
  amount_currency: 'IDR',  # Currency code
  user: user2
)

puts 'Finished seeding the database!'
