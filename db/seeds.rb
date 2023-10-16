# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts 'Cleaning database...'
Option.destroy_all
Membership.destroy_all

puts 'Creating memberships...'
daily = Membership.create!(name: 'Daily')
monthly = Membership.create!(name: 'Monthly')
yearly = Membership.create!(name: 'Yearly')

puts 'Creating options...'
Option.create!(
  price: 185000,
  sku: 'daily1',
  name: 'Daily Drop In',
  membership: daily,
  photo_url: 'https://res.cloudinary.com/dh8uxggfc/image/upload/v1695016688/Mejiro/Sparring_tev2ct.jpg'
)

Option.create!(
  price: 1250000,
  sku: 'monthly1',
  name: 'Monthly Membership',
  membership: monthly,
  photo_url: 'https://res.cloudinary.com/dh8uxggfc/image/upload/v1695016688/Mejiro/Muay_Thai_1_g8wizf.jpg'
)

Option.create!(
  price: 9000000,
  sku: 'yearly1',
  name: 'Yearly Membership',
  membership: yearly,
  photo_url: 'https://res.cloudinary.com/dh8uxggfc/image/upload/v1695016688/Mejiro/Sparring_tev2ct.jpg'
)

Option.create!(
  price: 700000,
  sku: 'kids1',
  name: 'Kids Membership',
  membership: monthly,
  photo_url: 'https://res.cloudinary.com/dh8uxggfc/image/upload/v1695016688/Mejiro/Muay_Thai_1_g8wizf.jpg'
)

puts 'Finished!'
