require 'rails_helper'

describe "Invoice Items API" do

  before(:each) do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    item = create(:item, merchant_id: merchant_id)
    invoice = create(:invoice, merchant_id: merchant_id, customer_id: customer_id)
    create_list(:invoice_item, 5, item_id: item.id, invoice_id: invoice.id)
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

  it "returns one invoice item" do
    get "/api/v1/invoice_items/#{InvoiceItem.first.id}"

    expect(response).to be_success

    invoice_item = JSON.parse(response.body)

    expect(invoice_item).to have_key("item_id")
    expect(invoice_item).to have_key("invoice_id")
    expect(invoice_item).to have_key("quantity")
    expect(invoice_item).to have_key("unit_price")
  end
end
