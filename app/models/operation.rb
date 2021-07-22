class Operation < ApplicationRecord
  belongs_to :receiver, class_name: 'User'
  belongs_to :sender, class_name: 'User', optional: true

  validates :currency, length: { is: 3 }, format: { with: /[A-Z]{3}/, message: "incorrect currency" }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
