require 'rails_helper'

describe "Invoice Relationships API" do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @invoices = create_list(:invoice, 5, merchant_id: @merchant.id, customer_id: @customer.id)
    @transaction = create(:transaction, invoice_id: @invoices.first.id)
  end

  it "can return a collection of associated transactions" do
    get "/api/v1/invoices/#{@invoices.first.id}/transactions"

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.first["id"]).to eq(@transaction.id)
  end

end
