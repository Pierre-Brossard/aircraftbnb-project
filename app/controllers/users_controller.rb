class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  before_action :set_user, only: %i[show destroy]

  def show
  end

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)
  #   @user.user = current_user
  #   if @user.save
  #     redirect_to users_path
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def destroy
    @user.destroy
    redirect_to users_path, status: :see_other
  end

  private

  # def user_params
  #   params.require(:user).permit(:name, :description, :email, :password)
  # end

  def set_user
    @user = User.find(params[:id])
  end
end
