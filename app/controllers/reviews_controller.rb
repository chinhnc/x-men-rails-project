class ReviewsController < ApplicationController
  load_and_authorize_resource

  def create
    @review = current_user.reviews.build review_params
    unless @review.save
      flash[:alert] = t "error"
    end
    redirect_to @review.anime
  end

  def show
    @comment = Comment.new
  end

  def edit
  end

  def update
    @review.update_attributes review_params
    respond_to do |format|
      format.html {redirect_to @review.anime}
      format.js
    end
  end

  def destroy
    @anime = @review.anime
    @review.destroy
    flash[:success] = t :destroysuccess
    redirect_to @anime
  end

  private
  def review_params
    params.require(:review).permit :title, :content, :image, :rate, :anime_id
  end
end
