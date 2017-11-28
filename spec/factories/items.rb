FactoryBot.define do
  factory :item do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "Name #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:unit_price) { |n| 111 * n}
    sequence(:merchant_id) { |n| 100 * n }
  end
end
