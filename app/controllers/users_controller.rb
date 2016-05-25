class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @cards = current_user.cards.order("created_at")
    @liked = current_user.find_voted_items.sort_by(&:created_at)
  end

  def update
    @user.update(user_params)
    redirect_to action: 'show', id: current_user.id
  end

  def edit
  end

  private

  def set_user
    @user = User.find(params[:id] || params[:user_id])
  end

  def user_params
    params.require(:user).permit(:name, :description)
  end
end
