class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @cards = current_user.cards
    @liked = current_user.find_voted_items
  end

  def update
  end

  def edit
  end
end
