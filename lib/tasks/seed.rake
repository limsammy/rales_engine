namespace :seed do
  desc "Seed Database"
  task import: :environment do
    require 'csv'

    Customer.all do |n|
      puts "seeding #{n}th customer"
      customers = CSV.read("#{Rails.root}/tmp/products.csv")
      columns = [:id, :first_name, :last_name, :created_at, :updated_at]
      Customer.import columns, customers, validate: false
    end
  end
end
