class Item < ApplicationRecord

  belongs_to :merchant
  has_many :item_invoices

end
