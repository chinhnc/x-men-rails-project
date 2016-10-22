class Admin::AnimesController < ApplicationController
  load_and_authorize_resource
  before_action :all_categories, only: [:new, :edit]

  def index
    @animes = @animes.includes :category
    @q = @animes.ransack params[:q]
    @animes = @q.result.order(created_at: :desc).paginate page: params[:page]
    @q.build_condition if @q.conditions.empty?
    @q.build_sort if @q.sorts.empty?
  end

  def new
  end

  def create
    if @anime.save
      flash[:success] = t :success
      redirect_to admin_animes_path
    else
      all_categories
      render :new
    end
  end

  def edit
  end

  def update
    if @anime.update_attributes anime_params
      flash[:success] = t :success
      redirect_to admin_animes_path
    else
      all_categories
      render :edit
    end
  end

  def destroy
    if @anime.destroy
      flash[:success] = t :success
    else
      flash[:danger] = t :error
    end
    redirect_to admin_animes_path
  end

  private
  def anime_params
    params.require(:anime).permit :title, :description, :episode, :image,
      :status, :publish_year, :category_id
  end

  def all_categories
    @categories = Category.all
    @status = Anime.statuses
  end
end
