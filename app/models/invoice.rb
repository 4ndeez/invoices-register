class Invoice < ApplicationRecord
  belongs_to :user

  validates :currency, length: { is: 3 }, format: { with: /[A-Z]{3}/, message: "incorrect currency" }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  validate :user_existence
  validate :invoice_uniqueness
  before_save :set_default_values

  private
  def set_default_values
    if self.new_record?
      self.amount = 0.0 unless self.amount.present?
      self.id = (self.user_id.to_s << self.currency.chars.map(&:ord).sum.to_s).to_i
    end
  end

  def user_existence
    errors.add(:user_id, "user id #{self.user_id} does not exist") unless self.user
  end

  def invoice_uniqueness
    return unless self.user
    if self.user.invoices.pluck(:currency).include? self.currency
      errors.add(:currency, "invoice with #{self.currency} already exists")
    end
  end
end
