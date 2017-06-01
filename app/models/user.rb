class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_create :generate_blog_title

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :blog, dependent: :destroy
  has_many :posts, dependent: :destroy
  validates :user_name, uniqueness: true

  mount_uploader :avatar, AvatarUploader
  acts_as_messageable

  def generate_blog_title
    Blog.create(title: self.user_name + "'s blog", user_id: self.id, description: 'Welcome to Blogger')
  end

  def admin!
    self.role = "admin"
    self.save
  end

  def mailboxer_email(object)
    email
  end
end
