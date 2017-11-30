require 'rails_helper'

describe "Item Relationship API" do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @item = create(:item, merchant_id: @merchant.id)
    @invoices = create_list(:invoice, 5, merchant_id: @merchant.id, customer_id: @customer.id)
    @transaction = create(:transaction, invoice_id: @invoices.first.id)
    @invoice_item = create(:invoice_item, item_id: @item.id, invoice_id: @invoices.first.id, unit_price: 1, quantity: 1)

    @items = create_list(:item, 3, merchant_id: @merchant.id)
    @invoice_item2 = create(:invoice_item, item_id: @items.first.id, invoice_id: @invoices.first.id, unit_price: 200, quantity: 2)
    @invoice_item3 = create(:invoice_item, item_id: @items.second.id, invoice_id: @invoices.second.id, unit_price: 100, quantity: 1)
    @invoice_item4 = create(:invoice_item, item_id: @items.third.id, invoice_id: @invoices.third.id, unit_price: 300, quantity: 3)
    @trx1 = create(:transaction, invoice_id: @invoices.first.id, result: "success")
    @trx2 = create(:transaction, invoice_id: @invoices.second.id, result: "success")
    @trx3 = create(:transaction, invoice_id: @invoices.third.id, result: "success")
  end

  it "can return a collection of associated invoice_items" do
    get "/api/v1/items/#{@item.id}/invoice_items"

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.first["quantity"]).to eq(@invoice_item.quantity)
  end

  it "can return associated merchant" do
    get "/api/v1/items/#{@item.id}/merchant"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant["name"]).to eq(@merchant.name)
  end

  it "can return top x items by revenue" do
    get "/api/v1/items/most_revenue?quantity=2"

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq(2)
    expect(items.first["name"]).to eq(@items.third.name)
    expect(items.second["name"]).to eq(@items.first.name)
  end

  it "can return top x items by revenue" do
    get "/api/v1/items/most_items?quantity=2"

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq(2)
    expect(items.first["name"]).to eq(@items.third.name)
    expect(items.second["name"]).to eq(@items.first.name)
  end
end
