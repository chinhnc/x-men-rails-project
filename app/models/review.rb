class Review < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  belongs_to :user
  belongs_to :anime
end
