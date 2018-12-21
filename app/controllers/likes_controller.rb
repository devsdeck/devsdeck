class LikesController < ApplicationController
  before_action :set_card
  before_action :authenticate_user!

  def create
    @card.upvote_by(current_user)
  end

  def destroy
    @card.downvote_by(current_user)
  end

  private

  def set_card
    @card = Card.find(params[:card_id])
  end
end
