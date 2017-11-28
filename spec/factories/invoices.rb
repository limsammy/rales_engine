FactoryBot.define do
  factory :invoice do
    sequence(:id) { |n| n }
    sequence(:customer_id) { |n| 100 * n }
    sequence(:merchant_id) { |n| 10000 * n }
    status "shipped"
    sequence(:created_at) { |n| "#{2000 + n}-03-25 09:54:09 UTC" }
    sequence(:updated_at) { |n| "#{8000 + n}-03-25 09:54:09 UTC" }
  end
end
