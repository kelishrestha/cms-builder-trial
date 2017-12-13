class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.integer :age
      t.date :date_of_birth
      t.boolean :has_paid

      t.timestamps
    end
  end
end
