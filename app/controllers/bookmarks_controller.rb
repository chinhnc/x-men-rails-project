class BookmarksController < ApplicationController
  load_and_authorize_resource

  def create
    @bookmark = current_user.bookmarks.build bookmark_params
    @bookmark.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @bookmark.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def bookmark_params
    params.require(:bookmark).permit :anime_id
  end
end
