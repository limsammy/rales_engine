require 'rails_helper'

describe "Invoices API" do
  before(:each) do
    create_list(:invoice, 5)
  end

  it "sends a collection of invoice objects" do
    get '/api/v1/invoices'

    expect(response).to be_success

    invoices = JSON.parse(response.body)
    invoice_1 = invoices.first

    expect(invoices.count).to eq(5)
    expect(invoice_1).to have_key("id")
    expect(invoice_1).to have_key("customer_id")
    expect(invoice_1).to have_key("merchant_id")
    expect(invoice_1).to have_key("status")
    expect(invoice_1).to have_key("created_at")
    expect(invoice_1).to have_key("updated_at")
  end

  it "sends an invoice object" do
    get '/api/v1/invoices/1'

    expect(response).to be_success

    invoice = JSON.parse(response.body)

    expect(invoice).to have_key("id")
    expect(invoice).to have_key("customer_id")
    expect(invoice).to have_key("merchant_id")
    expect(invoice).to have_key("status")
    expect(invoice).to have_key("created_at")
    expect(invoice).to have_key("updated_at")
  end
end
