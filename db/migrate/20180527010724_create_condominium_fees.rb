class CreateCondominiumFees < ActiveRecord::Migration[5.1]
  def change
    create_table :condominium_fees do |t|
      t.float :value
      t.datetime :due_date
      t.boolean :paid

      t.references :apartment, foreign_key: true

      t.timestamps
    end
  end
end
