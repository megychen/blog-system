class Category < ApplicationRecord
  validates :name, presence: true
  belongs_to :blog
  has_many :posts
end
