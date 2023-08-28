class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites
  has_many :book_comments
  has_many :follows, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follow_members, through: :follows, source: :followed
  has_many :follower_members, through: :followers, source: :follower
  

  
  has_many :group_users
  has_many :groups, through: :group_users, source: :group

  
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  def is_joined(group_id)
    self.groups.where('group_id = ?',group_id).length > 0
  end

  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  
  def is_followed_by(user)
    self.followers.pluck('follower_id').include?(user.id)
  end
  
  def posted_at(day)
    self.books.where('books.created_at like ? ',"%#{day}%")
  end
  
  def days_post(days_ago)
    self.books.where('books.created_at <= ?',days_ago.day.ago).where('books.created_at > ?',(days_ago+1).day.ago)
  end
  
  def todays_post
    self.books.where('books.created_at > ?',1.day.ago)
  end
  
  def predays_post
    self.books.where('books.created_at <= ?',1.day.ago).where('books.created_at > ?',2.day.ago)
  end
  
  def this_week_post
    self.books.where('books.created_at > ?',1.week.ago)
  end
  
  def pre_week_post
    self.books.where('books.created_at <= ?',1.week.ago).where('books.created_at > ?',2.week.ago)
  end
  
end
