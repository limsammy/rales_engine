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
    select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
      .joins(:transactions, :invoice_items)
      .group(:id)
      .order("total_revenue DESC")
      .limit(quantity)
  end

  def self.most_items(quantity)
    joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.where(result: 'success'))
      .group(:id)
      .order("SUM(quantity) DESC")
      .limit(quantity)
  end

  def self.total_revenue(date, id = nil)
    joins(invoices: [:transactions, :invoice_items])
      .where(Merchant.identify_single_merchant(id))
      .where(Merchant.filter_date(date))
      .merge(Transaction.successful)
      .sum("unit_price * quantity / 100.0")
  end

  def self.filter_date(date)
    {invoices: {created_at: date}} unless date.nil?
  end

  def self.identify_single_merchant(id)
    {id: id} unless id.nil?
  end

end
