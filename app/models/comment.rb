class Comment < ApplicationRecord
  include PublicActivity::Model
  tracked only: :create, owner: ->(controller, model) {controller.current_user}

  belongs_to :user
  belongs_to :review

  validates :user_id, presence: true
  validates :review_id, presence: true
  validates :content, length: {maximum: 200}, presence: true
end
