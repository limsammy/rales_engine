require 'rails_helper'

feature 'Customers API' do
  it 'returns all customers' do
    create_list(:customer, 5)

    get '/api/v1/customers'

    expect(response).to be_success

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(5)
  end

  it 'returns customer by id' do
    customer = create(:customer)

    get "/api/v1/customer/#{customer.id}"

    expect(response).to be_success

    parsed = JSON.parse(response.body)

    expect(parsed["id"]).to eq(customer.id.to_s)
  end
end