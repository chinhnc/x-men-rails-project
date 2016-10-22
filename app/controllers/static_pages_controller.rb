class StaticPagesController < ApplicationController
  def home
    @activities = PublicActivity::Activity.where(owner_id: current_user.id).order created_at: :desc
    @filterrific = initialize_filterrific(Anime, params[:filterrific]
    ) or return
    @animes = @filterrific.find.paginate page: params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
