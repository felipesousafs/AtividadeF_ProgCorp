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

  def value2f
    value.round(2)
  end

  def self.calc_fee_value(ap, due_date)
    fixed_values = (Expense.this_month(due_date).where(is_fixed_value: true).calculate(:sum, :value)/Apartment.total_rooms)*ap.number_of_rooms
    ap.expenses.this_month(due_date).calculate(:sum, :value) + fixed_values
  end

  def self.generate_condominium_fee(apartments = [], due_date)
    apartments.each do |ap|
      fee = CondominiumFee.new()
      fee.apartment = ap
      value = calc_fee_value(ap, due_date)
      fee.value = value
      fee.due_date = due_date
      puts "Uniq this #{due_date}: " + self.uniq_this_month_validator(ap, due_date).to_s
      if self.uniq_this_month_validator(ap, due_date)
        fee.save!
      end
    end
    true #if there are no errors, return true
  end

  def self.uniq_this_month_validator(ap, due_date)
    already_exists = CondominiumFee.where(apartment: ap)
    if already_exists.size > 0
      this_month = already_exists.where(created_at: due_date.beginning_of_month..due_date.end_of_month)
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
