class Anime < ApplicationRecord
  has_many :reviews, dependent: :destroy

  belongs_to :category

  enum status: ["complete", "ongoing"]
end
