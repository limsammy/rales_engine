class ChangeTransactionsCcNum < ActiveRecord::Migration[5.1]
  def change
    rename_column :transactions, :credit_card_number, :credit_card_number
  end
end
