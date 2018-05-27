class Expense < ApplicationRecord
  belongs_to :apartment, optional: true

  def self.this_month(date = Date.today)
    month_begins = date.beginning_of_month
    month_ends = date.end_of_month
    where(month_of_ref: month_begins..month_ends)
  end

end
