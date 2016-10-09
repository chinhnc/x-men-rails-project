class VotesController < ApplicationController
  def create
    @review = Review.find_by_id params[:review_id]
    current_user.likes @review
    respond_to do |format|
      format.js
      format.html {redirect_to @review.anime}
    end
  end

  def destroy
    @review = Review.find_by_id params[:id]
    current_user.dislikes @review
    respond_to do |format|
      format.js
      format.html {redirect_to @review.anime}
    end
  end
end
