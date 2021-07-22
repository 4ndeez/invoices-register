class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :currency
      t.references :receiver
      t.references :sender
      t.float :amount

      t.timestamps
    end
  end
end
