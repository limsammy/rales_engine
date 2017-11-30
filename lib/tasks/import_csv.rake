require 'csv'

namespace :import_csv do
  task customers: :environment do
    csv_text = File.read('./tmp/customers.csv')
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    puts "Starting customer import..."
    csv.each do |row|
      Customer.create!(row.to_hash)
    end
    puts "All customers imported!"
  end

  task merchants: :environment do
    csv_text = File.read('./tmp/merchants.csv')
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    puts "Starting merchants import..."
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end
    puts "All merchants imported!"
  end

  task items: :environment do
    csv_text = File.read('./tmp/items.csv')
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    puts "Starting items import..."
    csv.each do |row|
      Item.create!(row.to_hash)
    end
    puts "All items imported!"
  end

  task invoices: :environment do
    csv_text = File.read('./tmp/invoices.csv')
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    puts "Starting invoices import..."
    csv.each do |row|
      Invoice.create!(row.to_hash)
    end
    puts "All invoices imported!"
  end

  task transactions: :environment do
    csv_text = File.read('./tmp/transactions.csv')
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    puts "Starting transactions import..."
    csv.each do |row|
      Transaction.create!(row.to_hash)
    end
    puts "All transactions imported!"
  end

  task invoice_items: :environment do
    csv_text = File.read('./tmp/invoice_items.csv')
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    puts "Starting invoice_items import..."
    csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
    puts "All invoice_items imported!"
  end



  task all: [:customers, :merchants, :items, :invoices, :transactions, :invoice_items]
end