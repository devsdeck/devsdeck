class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :cards, :likes]
  before_action :authenticate_user!, except: [:cards, :likes]

  load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
    @cards = @user.latest_cards
    @liked = @user.latest_likes
    @total_likes = @user.total_likes
    @total_cards = @user.total_cards
  end

  def update
    @user.update(user_params)
    redirect_to action: 'show', id: @user.id
  end

  def edit
  end

  def cards
    @all_cards = @user.all_added_cards.page params[:page]
  end

  def likes
    @all_likes = @user.all_liked_cards.page params[:page]
  end

  private

  def set_user
    @user = User.find(params[:id] || params[:user_id])
  end

  def user_params
    params.require(:user).permit(:name, :description, :username, :email)
  end
end
