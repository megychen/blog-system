class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_create :generate_blog_title

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :blog
  has_many :posts
  validates :user_name, uniqueness: true

  mount_uploader :avatar, AvatarUploader

  def generate_blog_title
    Blog.create(title: self.user_name + "'s blog", user_id: self.id)
  end
end
