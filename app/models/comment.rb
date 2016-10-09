class Comment < ApplicationRecord
  acts_as_tree order: "created_at DESC"

  belongs_to :user
  belongs_to :review

  validates :user_id, presence: true
  validates :review_id, presence: true
  validates :content, length: {maximum: 200}
end
