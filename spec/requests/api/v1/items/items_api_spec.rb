require 'rails_helper'

describe "Items API" do

  before(:each) do
    merchant = create(:merchant)
    create_list(:item, 5, merchant_id: merchant.id)
  end

  it "sends a list of items" do
    get '/api/v1/items'

    expect(response).to be_success

    items = JSON.parse(response.body)
    item = items.first

    expect(items.count).to eq(5)
    expect(item).to have_key("id")
    expect(item).to have_key("name")
    expect(item).to have_key("description")
    expect(item).to have_key("unit_price")
    expect(item).to have_key("merchant_id")
  end

  it "sends an individual item" do
    get "/api/v1/items/#{Item.first.id}"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(item).to have_key("id")
    expect(item).to have_key("name")
    expect(item).to have_key("description")
    expect(item).to have_key("unit_price")
    expect(item).to have_key("merchant_id")
  end

  it "returns the best day an item had in terms of sales" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id,
      created_at: "2012-03-22T03:55:09.000Z")
    invoice2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id,
      created_at: "2012-03-22T03:55:09.000Z")

    get "/api/v1/items/#{item.id}/best_day"

    day = JSON.parse(response.body)

    expect(response).to be_success
    expect(day).to eq("2012-03-22T03:55:09.000Z")
  end
end
