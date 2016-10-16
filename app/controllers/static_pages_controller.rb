class StaticPagesController < ApplicationController
  def home
    @activities = PublicActivity::Activity.order created_at: :desc
  end

  def help
  end

  def about
  end

  def contact
  end
end
