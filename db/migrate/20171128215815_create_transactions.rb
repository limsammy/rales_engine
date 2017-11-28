class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :invoice, foreign_key: true
      t.string :cc_num
      t.string :cc_expiration
      t.string :result

      t.timestamps
    end
  end
end
