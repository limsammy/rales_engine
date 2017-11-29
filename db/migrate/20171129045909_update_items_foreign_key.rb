class UpdateItemsForeignKey < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :merchant_id, :integer
    add_reference :items, :merchant, foreign_key: true
  end
end
