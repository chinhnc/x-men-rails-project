class Category < ApplicationRecord
  has_many :animes, dependent: :destroy

  accepts_nested_attributes_for :animes, allow_destroy: true

  #validates :name, presence: true, uniqueness: true
  validates :name, presence: true
end
