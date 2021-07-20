class User < ApplicationRecord
  acts_as_taggable_on :tags
  before_save :downcase_tags

  validates :first_name, :last_name, :id_number, presence: true, length: { in: 2..26 }
  validates :middle_name, presence: false
  validates :id_number, uniqueness: true, numericality: { only_integer: true }

  def downcase_tags
    self.tag_list.map!(&:downcase)
  end
end
