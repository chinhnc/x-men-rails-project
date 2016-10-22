class Admin::CommentsController < ApplicationController
  load_and_authorize_resource

  def destroy
    if @comment.destroy
      flash[:success] = t :success
    else
      flash[:danger] = t :error
    end
    respond_to do |format|
      format.js
    end
  end
end
