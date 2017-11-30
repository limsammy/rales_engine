class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def favorite_customer
    customers.joins(:transactions)
    .merge(Transaction.where(result: 'success'))
    .group('customers.id')
    .order('count(customers.id) DESC')
    .first
  end

  def self.most_revenue(quantity)
    unscoped.select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
      .joins(:transactions, :invoice_items)
      .group(:id)
      .order("total_revenue DESC")
      .limit(quantity)
  end
end
