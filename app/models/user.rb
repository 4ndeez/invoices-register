class User < ApplicationRecord
  acts_as_taggable_on :tags
  has_many :invoices
  has_many :received_operations, class_name: 'Operation', foreign_key: 'receiver_id'
  has_many :sent_operations, class_name: 'Operation', foreign_key: 'sender_id'
  before_save :downcase_tags

  validates :first_name, :last_name, :id, presence: true, length: { in: 2..26 }
  validates :middle_name, presence: false
  validates :id, uniqueness: true, numericality: { only_integer: true }

  def downcase_tags
    self.tag_list.map!(&:downcase)
  end
end
