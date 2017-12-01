require 'rails_helper'

describe "Invoices API" do
  before(:each) do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    create_list(:invoice, 5, merchant_id: merchant_id, customer_id: customer_id)
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
  end

  it "sends an invoice object" do
    get "/api/v1/invoices/#{Invoice.first.id}"

    expect(response).to be_success

    invoice = JSON.parse(response.body)

    expect(invoice).to have_key("id")
    expect(invoice).to have_key("customer_id")
    expect(invoice).to have_key("merchant_id")
    expect(invoice).to have_key("status")
  end

  it "can find first instance by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    id = invoice.id

    get "/api/v1/invoices/find?id=#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(id)
  end

  it "can find first instance by customer" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    customer_id = customer.id

    get "/api/v1/invoices/find?customer_id=#{customer_id}"

    invoice_json = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_json["customer_id"]).to eq(customer_id)
  end

  it "can find first instance by merchant" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    merchant_id = merchant.id

    get "/api/v1/invoices/find?merchant_id=#{merchant_id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["merchant_id"]).to eq(merchant_id)
  end

  it "can find all instances by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/invoices/find_all?id=#{invoice.id}"

    invoice_json = JSON.parse(response.body)
    expect(response).to be_success
    expect(invoice_json.first["id"]).to eq(invoice.id)
  end

  it "can return a random invoice" do
    get "/api/v1/invoices/random"

    invoice = JSON.parse(response.body)

    expect(invoice).to have_key("id")
    expect(invoice).to have_key("customer_id")
    expect(invoice).to have_key("merchant_id")
    expect(invoice).to have_key("status")
  end
end
