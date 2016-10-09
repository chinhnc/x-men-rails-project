class Review < ApplicationRecord
  acts_as_votable

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  belongs_to :user
  belongs_to :anime

  has_attached_file :image, styles: {medium: "300x300>", thumb: "100x100>"},
    default_url: "/images/sao.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
