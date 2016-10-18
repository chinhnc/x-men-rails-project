class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @categories.ransack params[:q]
    @categories = @q.result.order(created_at: :desc).paginate page: params[:page]
    @q.build_sort if @q.sorts.empty?
  end

  def show
    @animes = @category.animes.order(created_at: :desc).paginate page: params[:page]
  end

  def new
    @category.animes.build
    @status = Anime.statuses
  end

  def create
    if @category.save
      redirect_to admin_category_path(@category)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t :success
      redirect_to admin_category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    @categories = Category.all.paginate page: params[:page]
    @q = @categories.ransack params[:q]
    @categories = @q.result.paginate page: params[:page]
    respond_to do |format|
      format.js
    end
  end

  private
  def category_params
    params.require(:category).permit :name,
      animes_attributes: [:title, :description, :episode, 
      :status, :publish_year, :image, :_destroy]
  end
end
