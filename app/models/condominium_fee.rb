class CondominiumFee < ApplicationRecord
  belongs_to :apartment

  def month_ref
    self.created_at
  end

  def paid_at
    if self.paid
      updated_at
    else
      false
    end
  end

  def self.generate_condominium_fee(apartments = [], due_date)
    apartments.each do |ap|
      fee = CondominiumFee.new()
      fee.apartment = ap
      value = ap.expenses.this_month.calculate(:sum, :value) + Expense.this_month(due_date).where(is_fixed_value: true).calculate(:sum, :value)
      fee.value = value
      fee.due_date = due_date + 15.days
      if self.uniq_this_month_validator(ap)
        fee.save!
      end
    end
    true #if there are no errors, return true
  end

  def self.uniq_this_month_validator(ap)
    already_exists = CondominiumFee.where(apartment: ap)
    puts already_exists.size
    if already_exists.size > 0
      this_month = already_exists.where(created_at: Date.today.beginning_of_month..Date.today.end_of_month)
      this_month.size
      if this_month.size > 0
        false
      else
        true
      end
    else
      true
    end
  end

end
