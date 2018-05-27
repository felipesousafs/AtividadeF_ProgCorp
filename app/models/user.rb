class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :apartments

  # My Apartments
  def apartments
    Apartment.where(owner: itself)
  end

  # Where I live
  def live_in
    Apartment.where(resident: itself)
  end
end