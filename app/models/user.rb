class User < ApplicationRecord
  validates :first_name, :last_name, :id_number, presence: true, length: { in: 2..26 }
  validates :middle_name, presence: false
  validates :id_number, uniqueness: true, numericality: { only_integer: true }
end
