class User < ApplicationRecord
  acts_as_voter

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
end
