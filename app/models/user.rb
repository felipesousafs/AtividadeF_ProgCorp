class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  has_many :apartments

  # My Apartments
  def apartments
    Apartment.where(owner: itself).or(Apartment.where(resident: itself))
  end

  # Where I live
  def live_in
    Apartment.where(resident: itself)
  end
end