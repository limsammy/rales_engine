require 'rails_helper'

describe "Merchants API" do
  it "returns all merchants" do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(5)
  end

  it 'returns merchant by id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant["id"]).to eq(id)
  end

  it 'can #find first instance by name' do
    id = create(:merchant).id

    get "/api/v1/merchants/find?id=#{id}"

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant['id']).to eq(id)
  end

  it 'can #find_all instances by name' do
    merchant_name = create_list(:merchant, 5).first.name

    get "/api/v1/merchants/find_all?first_name=#{merchant_name}"

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.first["name"]).to eq(merchant_name)
    expect(merchants.count).to eq(5)
  end

  it 'can return a random instance' do
    create_list(:merchant, 5)

    get '/api/v1/merchants/random'

    expect(response).to be_success

    merchant = JSON.parse(response.body)

    expect(merchant.count).to eq(1)
  end
end