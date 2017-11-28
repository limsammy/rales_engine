FactoryBot.define do
  factory :invoice_item do
    sequence(:item_id) { |n| n }
    sequence(:invoice_id) { |n| n }
    sequence(:quantity) { |n| 10 * n }
    sequence(:unit_price) { |n| 111 * n }
  end
end
