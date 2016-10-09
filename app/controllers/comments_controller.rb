class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @comments = Comment.hash_tree
  end

  def new
    @review = Review.find_by_id params[:review]
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
    if params[:comment][:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment].delete(:parent_id))
      @comment = parent.children.build(comment_params)
      @comment.user_id = current_user.id
    else
      @comment = current_user.comments.build comment_params
    end

    if @comment.save
      flash[:success] = t "success"
      redirect_to anime_path(@comment.review.anime)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @comment.update_attributes comment_params
    respond_to do |format|
      format.html {redirect_to @comment.review.anime}
      format.js
    end
  end

  def destroy
    if @comment.children.present?
      @comment.children.delete_all
      @comment.destroy
      flash[:success] = t "success"
      redirect_to anime_path(@comment.review.anime)
    else
      @comment.destroy
      respond_to do |format|
        format.html {redirect_to root_url}
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :review_id
  end
end
