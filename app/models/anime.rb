class Anime < ApplicationRecord
  has_many :reviews, dependent: :destroy

  belongs_to :category

  enum status: ["complete", "ongoing"]
  validates :title, presence: true
  validates :description, presence: true
  validates :episode, presence: true
  validates :image, presence: true
  validates :publish_year, presence: true,
    inclusion: { 
      in: 1000..Date.today.year, 
      message: ">= 1000 and <= current year" },
    format: { 
      with: /(10|20)\d{2}/i, 
      message: "should be a four-digit year"
    }
  validates :category_id, presence: true

  has_attached_file :image, styles: {medium: "300x300>", thumb: "100x100>"},
    default_url: "/images/sao.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  filterrific available_filters: %w[
    with_title
  ]

  scope :with_title, -> with_title {where "title like ?", "%#{with_title}%"}
end
