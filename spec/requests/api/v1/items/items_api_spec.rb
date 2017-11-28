require 'rails_helper'

describe "Items API" do
  before(:each) do
    create_list(:item, 5)
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
    expect(item).to have_key("created_at")
    expect(item).to have_key("updated_at")
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
    expect(item).to have_key("created_at")
    expect(item).to have_key("updated_at")
  end
end
