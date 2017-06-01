class Blog < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :categories, dependent: :destroy

  def to_param
    "#{self.id}-#{self.title}"
  end
end
