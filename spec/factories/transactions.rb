FactoryBot.define do
  factory :transaction do
    invoice nil
    cc_num "MyString"
    cc_expiration "MyString"
    result 1
  end
end
