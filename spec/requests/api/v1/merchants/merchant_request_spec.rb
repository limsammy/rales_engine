require 'rails_helper'

describe "Merchants API" do
  it "returns all merchants" do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(5)
  end
end