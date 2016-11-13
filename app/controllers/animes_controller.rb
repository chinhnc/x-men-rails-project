class AnimesController < ApplicationController
  def index
    @filterrific = initialize_filterrific(Anime, params[:filterrific]
    ) or return
    @animes = @filterrific.find.includes(:category, :reviews).paginate page: params[:page]
    @review_count = Review.group("reviews.anime_id").count
    @review_rating = Review.group("reviews.anime_id").average(:rate)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @anime = Anime.find_by_id params[:id]
    @review = Review.new
    @reviews = @anime.reviews.sort_by {|review| review.get_likes.size}.reverse
    @recently_posted_reviews = @anime.reviews.order created_at: :desc
  end
end
