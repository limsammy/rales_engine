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

  it "can return a single item with a given unit_price" do
    db_item = Item.second

    get "/api/v1/items/find?unit_price=#{db_item.unit_price/100.0}"

    expect(response).to be_success

    json_item = JSON.parse(response.body)

    expect(json_item["id"]).to eq(db_item.id)
  end

  it "can return a single item with a given unit_price" do
    db_item = Item.second
    create(:item, merchant_id: db_item.merchant_id, unit_price: db_item.unit_price)

    get "/api/v1/items/find_all?unit_price=#{db_item.unit_price/100.0}"

    expect(response).to be_success

    json_item = JSON.parse(response.body)

    expect(json_item.count).to eq(2)
    expect(json_item.first["id"]).to eq(db_item.id)
    expect(json_item.last["id"]).to eq(Item.last.id)
  end

  it 'returns day with most sales' do
    best_day = '2012-03-22T03:55:09.000Z'
    other_day = '2012-03-20T23:57:05.000Z'

    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    invoice_on_best_day = create(:invoice, created_at: best_day, customer_id: customer.id, merchant_id: merchant.id)
    invoice_on_other_day = create(:invoice, created_at: other_day, customer_id: customer.id, merchant_id: merchant.id)

    10.times do
      create(:invoice_item, item: item, invoice: invoice_on_best_day, quantity: 2)
    end

    12.times do
      create(:invoice_item, item: item, invoice: invoice_on_other_day, quantity: 1)
    end

    get "/api/v1/items/#{item.id}/best_day"
    response_day = JSON.parse(response.body)

    expect(response_day['best_day']).to eq best_day
  end

  it "can return a random item" do
    get "/api/v1/items/random"

    item = JSON.parse(response.body)

    expect(item).to have_key("id")
    expect(item).to have_key("name")
    expect(item).to have_key("description")
    expect(item).to have_key("unit_price")
    expect(item).to have_key("merchant_id")
  end
end
