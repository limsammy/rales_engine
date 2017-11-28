class ChangeTransactionsCcNum < ActiveRecord::Migration[5.1]
  def change
    rename_column :transactions, :cc_expiration, :credit_card_expiration_dateß
  end
end
