class AnimesController < ApplicationController
  def index
    @animes = Anime.all
  end

  def show
    @anime = Anime.find_by_id params[:id]
    @review = Review.new
    @reviews = @anime.reviews
  end
end
