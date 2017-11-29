require 'rails_helper'

describe "Customer Business Intelligence" do
  it "returns the merchant who has conducted the most total number of successful transactions" do
    customer = create(:customer)
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    item = create(:item, merchant_id: merchant.id, unit_price: 100)

    invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 2, item_id: item.id)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, quantity: 2, item_id: item.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id, result: "success")

    invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
    invoice_item3 = create(:invoice_item, invoice_id: invoice3.id, quantity: 2, item_id: item.id)
    transaction1 = create(:transaction, invoice_id: invoice3.id, result: "success")

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    fav_merchant = JSON.parse(response.body)
    expect(fav_merchant["id"]).to eq(merchant.id)
  end
end