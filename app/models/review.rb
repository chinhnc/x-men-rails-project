class Review < ApplicationRecord
  include PublicActivity::Model
  tracked only: :create, owner: ->(controller, model) {controller.current_user}

  acts_as_votable
  
  validates :rate, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 10}

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  belongs_to :user
  belongs_to :anime

  has_attached_file :image, styles: {medium: "300x300>", thumb: "100x100>"},
    default_url: "/images/sao.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
