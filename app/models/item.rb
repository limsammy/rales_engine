class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def best_day
    invoices.joins(:invoice_items)
      .group('invoices.id, invoices.created_at')
      .order('sum(invoice_items.quantity) DESC, invoices.created_at DESC')
      .first
      .created_at
  end

  def self.most_revenue(quantity)
    joins(invoices: :transactions)
      .merge(Transaction.successful)
      .group(:id)
      .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
      .limit(quantity)
  end
end
