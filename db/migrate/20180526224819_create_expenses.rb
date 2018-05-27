class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.string :description
      t.boolean :is_fixed_value
      t.float :value
      t.datetime :month_of_ref
      t.belongs_to :apartment, optional: true

      t.timestamps
    end
  end
end
