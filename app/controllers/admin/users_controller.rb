class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @users.ransack params[:q]
    @users = @q.result.where(is_admin: false).order(created_at: :desc).paginate page: params[:page]
    @q.build_sort if @q.sorts.empty?
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Update successful!"
      redirect_to admin_users_path
    else
      flash[:danger] = "Update fails!"
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email,
      :password, :password_confirmation
  end
end
