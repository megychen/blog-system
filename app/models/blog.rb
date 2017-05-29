class Blog < ApplicationRecord
  validates :title, uniqueness: true
  belongs_to :user
  has_many :posts
  has_many :categories

  def to_param
    "#{self.id}-#{self.title}"
  end
end
