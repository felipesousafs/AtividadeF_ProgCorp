class Apartment < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :resident, class_name: 'User'
  has_many :expenses
  has_many :condominium_fees


  def self.total_rooms
    Apartment.all.calculate(:sum, :number_of_rooms)
  end
  
end