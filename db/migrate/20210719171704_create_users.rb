class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :id_number
      t.string :first_name
      t.string :second_name
      t.string :middle_name

      t.timestamps
    end
  end
end
