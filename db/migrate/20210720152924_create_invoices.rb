class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.string :currency
      t.references :user, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
