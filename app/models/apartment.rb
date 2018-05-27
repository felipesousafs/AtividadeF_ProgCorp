class Apartment < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :resident, class_name: 'User'
  has_many :expenses
end