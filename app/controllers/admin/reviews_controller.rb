class Admin::ReviewsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @reviews.ransack params[:q]
    @reviews = @q.result.order(created_at: :desc).paginate page: params[:page]
    @q.build_condition if @q.conditions.empty?
    @q.build_sort if @q.sorts.empty?
  end

  def show
  end

  def destroy
    if @review.destroy
      flash[:success] = t :success
    else
      flash[:danger] = t :error
    end
    redirect_to admin_reviews_path
  end
end
