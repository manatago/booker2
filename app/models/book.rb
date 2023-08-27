class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user
  has_many :book_comments
  
  validates :title,presence: true,length:{minimum: 1}
  validates :body,presence: true,length:{maximum: 200}
end
