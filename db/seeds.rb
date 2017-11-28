# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

csv_text = File.read("#{Rails.root}/tmp/customers.csv")
csv = CSV.parse(csv_text, :headers => true)
n = 0
csv.each do |row|
  puts "Seeding customer #{n}th times"
  n += 1
  Customer.create!(row.to_hash)
end