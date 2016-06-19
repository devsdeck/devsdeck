class TagsController < ApplicationController
  before_action :set_tag
  before_action :set_cards
  before_action :set_search
  before_action :authenticate_user!

  def cards
  end

  private

  def set_cards
    @cards = @tag.cards
  end

  def set_search
    @q = Card.ransack(params[:q])
    @q.result.includes(:tags)
    @q.sorts = "created_at desc" if @q.sorts.empty?
  end

  def set_tag
    @tag = Tag.find(params["id"])
  end
end
