class Post < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  belongs_to :blog

  scope :recent, -> { order("created_at DESC") }
end
