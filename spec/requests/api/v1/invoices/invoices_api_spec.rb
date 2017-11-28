require 'rails_helper'

describe "Invoices API" do
  it "sends a collection of invoice objects" do
    create_list(:invoice, 5)

    get '/api/v1/invoices'

    expect(response).to be_success

    invoices = JSON.parse(response.body)
    invoice_1 = invoices.first

    expect(invoices.count).to eq(5)
    expect(invoice_1["id"]).to eq(invoice_1.id)
    expect(invoice_1["customer_id"]).to eq(invoice_1.customer_id)
    expect(invoice_1["merchant_id"]).to eq(invoice_1.merchant_id)
    expect(invoice_1["status"]).to eq(invoice_1.status)
    expect(invoice_1["created_at"]).to eq(invoice_1.created_at)
    expect(invoice_1["updated_at"]).to eq(invoice_1.updated_at)
  end
end
