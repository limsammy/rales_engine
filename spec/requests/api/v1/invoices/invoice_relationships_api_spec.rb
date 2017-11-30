require 'rails_helper'

describe "Invoice Relationships API" do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @item = create(:item, merchant_id: @merchant.id)
    @invoices = create_list(:invoice, 5, merchant_id: @merchant.id, customer_id: @customer.id)
    @transaction = create(:transaction, invoice_id: @invoices.first.id)
    @invoice_item = create(:invoice_item, item_id: @item.id, invoice_id: @invoices.first.id)
  end

  it "can return a collection of associated transactions" do
    get "/api/v1/invoices/#{@invoices.first.id}/transactions"

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.first["id"]).to eq(@transaction.id)
  end

  it "can return a collection of associated invoice items" do
    get "/api/v1/invoices/#{@invoices.first.id}/invoice_items"

    expect(response).to be_success

    associated_invoice_items = JSON.parse(response.body)

    expect(associated_invoice_items.first["id"]).to eq(@invoice_item.id)
  end

  it "can return a collection of associated items" do
    get "/api/v1/invoices/#{@invoices.first.id}/items"

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.first["name"]).to eq(@item.name)
  end

  it "can return associated customer" do
    get "/api/v1/invoices/#{@invoices.first.id}/customer"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["first_name"]).to eq(@customer.first_name)
  end

  it "can return associated merchant" do
    get "/api/v1/invoices/#{@invoices.first.id}/merchant"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant["name"]).to eq(@merchant.name)
  end
end
