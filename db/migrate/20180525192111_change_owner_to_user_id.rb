class ChangeOwnerToUserId < ActiveRecord::Migration[5.1]
  def change
    drop_table :apartments
    create_table :apartments do |t|
      t.integer :number
      t.integer :number_of_rooms
      t.belongs_to :resident
      t.belongs_to :owner

      t.timestamps
    end
  end
end
