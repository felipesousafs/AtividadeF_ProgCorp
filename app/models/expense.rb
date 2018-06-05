class Expense < ApplicationRecord
  belongs_to :apartment, optional: true

  def self.this_month(date)
    month_begins = date.beginning_of_month
    month_ends = date.end_of_month
    where(month_of_ref: month_begins..month_ends)
  end

  def value2f
    value.round(2)
  end

  def self.by_apartment(ap)
    Expense.where(is_fixed_value: true).or(Expense.where(apartment_id: ap.id)).order(updated_at: :desc)
  end

end
