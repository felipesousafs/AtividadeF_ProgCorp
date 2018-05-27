class CondominiumFee < ApplicationRecord 
  belongs_to :apartment

  def paid_at
    if self.paid
      updated_at
    else
      false
    end
  end
end
