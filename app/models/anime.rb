class Anime < ApplicationRecord
  has_many :reviews, dependent: :destroy

  belongs_to :category

  enum status: ["complete", "ongoing"]

  mount_uploader :image, ImageUploader
end
