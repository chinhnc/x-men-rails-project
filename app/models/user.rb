class User < ApplicationRecord
  acts_as_voter

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def review_anime? anime_id
    reviews.find_by anime_id: anime_id
  end

  def bookmark_anime? anime_id
    bookmarks.find_by anime_id: anime_id
  end
end
