class CreateApartments < ActiveRecord::Migration[5.1]
  def change
    create_table :apartments do |t|
      t.integer :number
      t.integer :number_of_rooms
      t.integer :resident
      t.integer :owner_id

      t.timestamps
    end
  end
end
