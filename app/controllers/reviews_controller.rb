class ReviewsController < ApplicationController
  load_and_authorize_resource

  def create
    @review = current_user.reviews.build review_params
    @comments = Comment.hash_tree
    unless @review.save
      flash[:alert] = t "error"
    end
    redirect_to @review.anime
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
    @review.destroy
    respond_to do |format|
      format.html {redirect_to @review.anime}
      format.js
    end
  end

  private
  def review_params
    params.require(:review).permit :content, :rate, :anime_id
  end
end
