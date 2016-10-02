class Category < ApplicationRecord
  has_many :animes, dependent: :destroy
end
