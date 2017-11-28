FactoryBot.define do
  factory :transaction do
    invoice nil
    credit_card_number "MyString"
    cc_expiration "MyString"
    result 1
  end
end
