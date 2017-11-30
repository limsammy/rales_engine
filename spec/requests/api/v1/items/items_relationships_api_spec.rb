require 'rails_helper'

describe "Item Relationship API" do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @item = create(:item, merchant_id: @merchant.id)
    @invoices = create_list(:invoice, 5, merchant_id: @merchant.id, customer_id: @customer.id)
    @transaction = create(:transaction, invoice_id: @invoices.first.id)
    @invoice_item = create(:invoice_item, item_id: @item.id, invoice_id: @invoices.first.id)
  end

  it "can return a collection of associated invoice_items" do
    get "/api/v1/items/#{@item.id}/invoice_items"

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.first["quantity"]).to eq(@invoice_item.quantity)
  end

end
