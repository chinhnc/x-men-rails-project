class UsersController < ApplicationController
  def show
    @user = User.find_by_id params[:id]
    @activities = PublicActivity::Activity.order("created_at DESC").where owner_id: params[:id]
  end
end
