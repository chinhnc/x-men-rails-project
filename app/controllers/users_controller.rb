class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @activities = PublicActivity::Activity.order("created_at DESC").where owner_id: params[:id]
  end
end
