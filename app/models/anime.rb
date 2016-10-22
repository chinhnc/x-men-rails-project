class Anime < ApplicationRecord
  has_many :reviews, dependent: :destroy

  belongs_to :category

  enum status: ["complete", "ongoing"]
  validates :title, presence: true

  has_attached_file :image, styles: {medium: "300x300>", thumb: "100x100>"},
    default_url: "/images/sao.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  filterrific available_filters: %w[
    with_title
  ]

  scope :with_title, -> with_title {where "title like ?", "%#{with_title}%"}
end
