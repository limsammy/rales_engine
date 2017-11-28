class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.invoice :references
      t.string :cc_num
      t.string :cc_expiration
      t.integer :result

      t.timestamps
    end
  end
end
