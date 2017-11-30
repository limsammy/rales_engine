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
    most_by("sum(invoice_items.quantity * invoice_items.unit_price) DESC", quantity)
  end

  def self.most_items(quantity)
    most_by("sum(invoice_items.quantity) DESC", quantity)
  end

  def self.most_by(criteria, quantity)
    joins(invoices: :transactions)
      .merge(Transaction.successful)
      .group(:id)
      .order(criteria)
      .limit(quantity)
  end
end
