class Photo < ApplicationRecord
  belongs_to :user
  validates :image, presence: true
  mount_uploader :image, ImageUploader
end
