class UsersController < ApplicationController
  def show
    @activities = PublicActivity::Activity.order("created_at DESC").where owner_id: current_user.id
  end
end
