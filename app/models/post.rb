class Post < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  belongs_to :blog
  belongs_to :category, optional: true, counter_cache: true

  scope :recent, -> { order("created_at DESC") }
end
