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
    id = create(:customer).id

    get "/api/v1/customer/#{customer.id}"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer["id"]).to eq(id)
  end

  it 'can #find first instance by name' do
    id = create(:customer).id

    get "/api/v1/customers/find?id=#{id}"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer['id']).to eq(id)
  end

  it 'can #find_all instances by name' do
    first_name = create_list(:customer, 5).first.first_name

    get "/api/v1/customers/find_all?first_name=#{first_name}"

    expect(response).to be_success

    customers = JSON.parse(response.body)

    expect(customers.first["first_name"]).to eq(first_name)
    expect(customers.count).to eq(5)
  end
end