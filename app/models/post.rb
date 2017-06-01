class Post < ApplicationRecord
  validates :title, presence: true
  belongs_to :user
  belongs_to :blog, counter_cache: true
  belongs_to :category, optional: true, counter_cache: true

  acts_as_votable
  is_impressionable

  scope :recent, -> { order("created_at DESC") }

  STATUS = ["draft", "public", "private"]
  validates_inclusion_of :status, :in => STATUS

  def draft!
    self.update(:status => "draft")
  end

  def publish!
    self.update(:status => "public")
  end

  def hide!
    self.update(:status => "private")
  end

  def to_param
    "#{self.id}-#{self.title}"
  end
end
