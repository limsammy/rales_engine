require 'rails_helper'

describe "Invoice Items API" do

  before(:each) do
    create_list(:invoice_item, 5)
  end

  it "returns all invoice items" do
    get '/api/v1/invoice_items'

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(5)
    expect(invoice_items.first).to have_key("item_id")
    expect(invoice_items.first).to have_key("invoice_id")
    expect(invoice_items.first).to have_key("quantity")
    expect(invoice_items.first).to have_key("unit_price")
  end
end
