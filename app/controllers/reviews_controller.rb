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

  def update
    if @review.update_attributes review_params
      flash[:success] = t "success"
    else
      flash[:danger] = t "error"
    end
    redirect_to @review.anime
  end

  private
  def review_params
    params.require(:review).permit :content, :rate, :image, :anime_id
  end
end
