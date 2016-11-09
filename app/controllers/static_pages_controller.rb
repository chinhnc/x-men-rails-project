class StaticPagesController < ApplicationController
  def home
    @filterrific = initialize_filterrific(Anime, params[:filterrific],
      select_options: {sorted_by: Anime.options_for_sorted_by,
        with_category_id: Category.options_for_select}
    ) or return
    @animes = @filterrific.find.includes(:category, :reviews).paginate page: params[:page]
    @review_count = Review.group("reviews.anime_id").count
    @review_rating = Review.group("reviews.anime_id").average(:rate)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
