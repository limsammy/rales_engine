class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  belongs_to :merchant
end
