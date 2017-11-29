class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    merchants.joins(invoices: :transactions)
      .merge(Transaction.where(result: 'success'))
      .group('merchants.id')
      .order('count(merchants.id) DESC')
      .first
  end
end
