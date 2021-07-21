class RemoveIdNumberFromUser < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :id_number
  end

  def down
    add_column :users, :id_number, :integer
  end
end
