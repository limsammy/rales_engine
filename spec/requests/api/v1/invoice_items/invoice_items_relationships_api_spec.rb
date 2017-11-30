require 'rails_helper'

describe "Invoice Items Relationships API" do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @item = create(:item, merchant_id: @merchant.id)
    @invoices = create_list(:invoice, 5, merchant_id: @merchant.id, customer_id: @customer.id)
    @transaction = create(:transaction, invoice_id: @invoices.first.id)
    @invoice_item = create(:invoice_item, item_id: @item.id, invoice_id: @invoices.first.id)
  end

  it "can return associated item" do
    get "/api/v1/invoice_items/#{@invoice_item.id}/item"

    expect(response).to be_success

    item = JSON.parse(response.body)

    expect(item["name"]).to eq(@item.name)
  end

  it "can return associated invoice" do
    get "/api/v1/invoice_items/#{@invoice_item.id}/invoice"

    expect(response).to be_success

    invoice = JSON.parse(response.body)

    expect(invoice["merchant_id"]).to eq(@invoices.first.merchant_id)
  end
end
