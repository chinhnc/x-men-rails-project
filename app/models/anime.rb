class Anime < ApplicationRecord
  has_many :reviews, dependent: :destroy

  belongs_to :category

  enum status: ["complete", "ongoing"]
  validates :title, presence: true
  validates :description, presence: true
  validates :episode, presence: true
  validates :image, presence: true
  validates :publish_year, presence: true,
    format: {
      with: /(19|20)\d{2}/i,
      message: "should be a valid year"
    }

  has_attached_file :image, styles: {medium: "300x300>", thumb: "100x100>"},
    default_url: "/images/sao.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  self.per_page = 10

  filterrific default_filter_params: {sorted_by: "rating_desc"},
    available_filters: %w[
      search_query
      sorted_by
      with_category_id
    ]

  scope :search_query, lambda {|query|
    return nil if query.blank?
    where "LOWER(animes.title) LIKE ?", "%#{query.downcase}%"
  }
  scope :with_category_id, lambda { |category_ids|
    where category_id: [*category_ids]
  }
  scope :sorted_by, lambda {|sort_option|
    direction = (sort_option =~ /desc$/) ? "desc" : "asc"
    case sort_option.to_s
    when /^name_/
      order "LOWER(animes.title) #{direction}"
    when /^rating_/
      #references(:reviews).group("animes.id").order "avg(reviews.rate) #{direction}"
      left_outer_joins(:reviews).group("animes.id").order "avg(reviews.rate) #{direction}"
    when /^number_of_reviews_/
      left_outer_joins(:reviews).group("animes.id").order "count(reviews.id) #{direction}"
    when /^anime_reviewed_at_/
      joins(:reviews).distinct.group("animes.id").order "reviews.created_at #{direction}"
    else
      raise ArgumentError, "Invalid sort option: #{sort_option.inspect}"
    end
  }

  class << self
    def options_for_sorted_by
      [
        ["Name (a-z)", "name_asc"],
        ["Name (z-a)", "name_desc"],
        ["Rating Asc", "rating_asc"],
        ["Rating Desc", "rating_desc"],
        ["Numbers of Review Asc", "number_of_reviews_asc"],
        ["Numbers of Review Desc", "number_of_reviews_desc"],
        ["Newest Reviewed Anime", "anime_reviewed_at_desc"],
        ["Oldest Reviewed Anime", "anime_reviewed_at_asc"]
      ]
    end
  end
end
