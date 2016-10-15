class AnimesController < ApplicationController
  def index
    @filterrific = initialize_filterrific( Anime, params[:filterrific]
    ) or return
    @animes = @filterrific.find.paginate page: params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @anime = Anime.find_by_id params[:id]
    @review = Review.new
    @reviews = @anime.reviews
  end
end
