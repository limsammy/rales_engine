class ChangeTransactionsCcNum < ActiveRecord::Migration[5.1]
  def change
    rename_column :transactions, :cc_num, :credit_card_number
  end
end
