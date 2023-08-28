class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :book_accesses, dependent: :destroy
  validates :title,presence: true,length:{minimum: 1}
  validates :body,presence: true,length:{maximum: 200}
  
  has_one_attached :book_image
end
