# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# db/seeds.rb
puts 'Cleaning database...'
Category.destroy_all
Membership.destroy_all


puts 'Creating categories...'
short = Category.create!(name: 'short')
long = Category.create!(name: 'long')

puts 'Creating memberships...'
ActiveRecord::Base.transaction do
Membership.create!(sku: 'daily', name: 'Daily Drop In', category: short, price: 1800000, photo_url: 'http://onehdwallpaper.com/wp-content/uploads/2015/07/Teddy-Bears-HD-Images.jpg')
Membership.create!(sku: 'monthly', name: 'Monthly', category: long, price: 120000000, photo_url: 'https://pbs.twimg.com/media/B_AUcKeU4AE6ZcG.jpg:large')
Membership.create!(sku: 'yearly', name: 'Yearly', category: long, price: 900000000, photo_url: 'https://cdn-ak.f.st-hatena.com/images/fotolife/s/suzumidokoro/20160413/20160413220730.jpg')
end

puts 'Finished!'
