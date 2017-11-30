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
end
