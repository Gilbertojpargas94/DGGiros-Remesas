class User < ApplicationRecord
  has_many :quotations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  validates :phone, phone: { possible: true, allow_blank: true }
  validates :name, presence: true
  validates_confirmation_of :password
end
