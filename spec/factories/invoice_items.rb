FactoryBot.define do
  factory :invoice_item do
    sequence(:quantity) { |n| 10 * n }
    sequence(:unit_price) { |n| 111 * n }
  end
end
