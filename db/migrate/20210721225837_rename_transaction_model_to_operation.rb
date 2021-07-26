class RenameTransactionModelToOperation < ActiveRecord::Migration[5.2]
  def up
    rename_table :transactions, :operations
  end

  def down
    rename_table :operations, :transactions
  end
end
