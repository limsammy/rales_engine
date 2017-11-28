require 'csv'

namespace :import_csv do
  task customers: :environment do
    csv_text = File.read('./tmp/customers.csv')
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    csv.each do |row|
      Customer.create!(row.to_hash)
    end
  end

  task merchants: :environment do
    csv_text = File.read('./tmp/merchants.csv')
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end
  end

  task items: :environment do
    csv_text = File.read('./tmp/items.csv')
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    csv.each do |row|
      Item.create!(row.to_hash)
    end
  end

  task invoices: :environment do
    csv_text = File.read('./tmp/invoices.csv')
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    csv.each do |row|
      Invoice.create!(row.to_hash)
    end
  end

  task transactions: :environment do
    csv_text = File.read('./tmp/transactions.csv')
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    csv.each do |row|
      Transaction.create!(row.to_hash)
    end
  end

  task invoice_items: :environment do
    csv_text = File.read('./tmp/invoice_items.csv')
    csv = CSV.parse(csv_text, :headers => true, header_converters: :symbol)
    csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end



  task all: [:customers, :merchants, :items, :invoices, :transactions, :invoice_items]
end