require 'rails_helper'

describe "Merchant Business Intelligence" do
  it "returns the customer who has conducted the most total number of successful transactions" do
    customer = create(:customer)
    customer2 = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id, unit_price: 100)

    invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 2, item_id: item.id)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, quantity: 2, item_id: item.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id, result: "success")

    invoice3 = create(:invoice, customer_id: customer2.id, merchant_id: merchant.id)
    invoice_item3 = create(:invoice_item, invoice_id: invoice3.id, quantity: 2, item_id: item.id)
    transaction1 = create(:transaction, invoice_id: invoice3.id, result: "success")

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    fav_customer = JSON.parse(response.body)
    expect(fav_customer["id"]).to eq(customer.id)
  end

  it "returns the top x merchants ranked by total revenue" do
    customer = create(:customer)
    merchant1, merchant2, merchant3 = create_list(:merchant, 3)
    item1 = create(:item, merchant_id: merchant1.id, unit_price: 100)
    item2 = create(:item, merchant_id: merchant2.id, unit_price: 100)
    item3 = create(:item, merchant_id: merchant3.id, unit_price: 100)

    invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 2, item_id: item1.id)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")

    invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
    invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, quantity: 1, item_id: item2.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id, result: "success")

    invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant3.id)
    invoice_item3 = create(:invoice_item, invoice_id: invoice3.id, quantity: 3, item_id: item3.id)
    transaction3 = create(:transaction, invoice_id: invoice3.id, result: "success")

    get "/api/v1/merchants/most_revenue?quantity=2"

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(2)
    expect(merchants.first["id"]).to eq(merchant3.id)
    expect(merchants.last["id"]).to eq(merchant1.id)

  end

  it "returns the top x items ranked by quantity" do
    customer = create(:customer)
    merchant1, merchant2, merchant3 = create_list(:merchant, 3)
    item1 = create(:item, merchant_id: merchant1.id, unit_price: 100)
    item2 = create(:item, merchant_id: merchant2.id, unit_price: 100)
    item3 = create(:item, merchant_id: merchant3.id, unit_price: 100)

    invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 2, item_id: item1.id)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")

    invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
    invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, quantity: 1, item_id: item2.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id, result: "success")

    invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant3.id)
    invoice_item3 = create(:invoice_item, invoice_id: invoice3.id, quantity: 3, item_id: item3.id)
    transaction3 = create(:transaction, invoice_id: invoice3.id, result: "success")


    get "/api/v1/merchants/most_items?quantity=2"

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(2)
    expect(merchants.first["id"]).to eq(merchant3.id)
    expect(merchants.last["id"]).to eq(merchant1.id)
  end

  it "returns the total revenue for that merchant across successful transactions" do
    customer = create(:customer)
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id, unit_price: 200)

    invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 2, unit_price: 200, item_id: item1.id)
    invoice_item2 = create(:invoice_item, invoice_id: invoice1.id, quantity: 1, unit_price: 200, item_id: item1.id)
    invoice_item3 = create(:invoice_item, invoice_id: invoice1.id, quantity: 3, unit_price: 200, item_id: item1.id)

    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    transaction2 = create(:transaction, invoice_id: invoice1.id, result: "failed")
    transaction3 = create(:transaction, invoice_id: invoice1.id, result: "success")

    get "/api/v1/merchants/#{merchant.id}/revenue"

    revenue = JSON.parse(response.body)

    expect(revenue["revenue"]).to eq("24.0")
  end

  it "returns the total revenue for that merchant across successful transactions on a date" do
    customer = create(:customer)
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id, unit_price: 200)
    that_one_day = "2012-03-25 09:54:09 UTC"

    invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, created_at: that_one_day)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 2, unit_price: 200, item_id: item1.id)
    invoice_item2 = create(:invoice_item, invoice_id: invoice1.id, quantity: 1, unit_price: 200, item_id: item1.id)
    invoice_item3 = create(:invoice_item, invoice_id: invoice1.id, quantity: 3, unit_price: 200, item_id: item1.id)

    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    transaction2 = create(:transaction, invoice_id: invoice1.id, result: "failed")
    transaction3 = create(:transaction, invoice_id: invoice1.id, result: "success")

    invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item4 = create(:invoice_item, invoice_id: invoice2.id, quantity: 4, unit_price: 200, item_id: item1.id)
    transaction4 = create(:transaction, invoice_id: invoice2.id, result: "success")

    that_one_day_url = "2012-03-25 09:54:09"
    get "/api/v1/merchants/#{merchant.id}/revenue?date=#{that_one_day_url}"

    revenue = JSON.parse(response.body)
    expect(revenue["revenue"]).to eq("24.0")
  end

  it "returns the total revenue for all merchants across successful transactions on a date" do
    customer = create(:customer)
    merchant = create(:merchant)
    item1 = create(:item, merchant_id: merchant.id, unit_price: 200)
    that_one_day = "2012-03-25 09:54:09 UTC"

    invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, created_at: that_one_day)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 2, unit_price: 200, item_id: item1.id)
    invoice_item2 = create(:invoice_item, invoice_id: invoice1.id, quantity: 1, unit_price: 200, item_id: item1.id)
    invoice_item3 = create(:invoice_item, invoice_id: invoice1.id, quantity: 3, unit_price: 200, item_id: item1.id)

    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    transaction2 = create(:transaction, invoice_id: invoice1.id, result: "failed")
    transaction3 = create(:transaction, invoice_id: invoice1.id, result: "success")

    merchant2 = create(:merchant)
    invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id, created_at: that_one_day)
    invoice_item4 = create(:invoice_item, invoice_id: invoice2.id, quantity: 4, unit_price: 200, item_id: item1.id)
    transaction4 = create(:transaction, invoice_id: invoice2.id, result: "success")

    merchant3 = create(:merchant)
    invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant3.id)
    invoice_item5 = create(:invoice_item, invoice_id: invoice3.id, quantity: 4, unit_price: 200, item_id: item1.id)

    that_one_day_url = "2012-03-25 09:54:09"
    get "/api/v1/merchants/revenue?date=#{that_one_day_url}"

    revenue = JSON.parse(response.body)
    expect(revenue["total_revenue"]).to eq("32.0")
  end
end
