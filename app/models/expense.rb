class Expense < ApplicationRecord
  belongs_to :apartment, optional: true
end
