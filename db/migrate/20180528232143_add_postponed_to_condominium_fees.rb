class AddPostponedToCondominiumFees < ActiveRecord::Migration[5.1]
  def change
    add_column :condominium_fees, :postponed, :boolean
  end
end
