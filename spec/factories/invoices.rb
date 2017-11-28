FactoryBot.define do
  factory :invoice do
    sequence(:id) { |n| n }
    sequence(:customer_id) { |n| 100 * n }
    sequence(:merchant_id) { |n| 10000 * n }
    status "shipped"
  end
end
