class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy, :like_or_unlike]
  before_action :set_search, except: [:like_or_unlike]
  before_action :set_tags, except: [:index, :show, :like_or_unlike]
  before_action :authenticate_user!, except: [:index, :show]

  load_and_authorize_resource

  def index
    @cards = @q.result(distinct: true).includes(:user, :tags).page params[:page]
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = current_user.cards.new(card_params)
    CardTaggerService.new(@card, params[:tags].to_a).perform
    @card.save
    respond_with(@card)
  end

  def update
    @card.update(card_params)
    CardTaggerService.new(@card, params[:tags].to_a).perform
    respond_with(@card)
  end

  def destroy
    @card.destroy
    respond_with(@card)
  end

  private

  def set_card
    @card = Card.find(params[:id] || params[:card_id])
  end

  def card_params
    params.require(:card).permit(:name, :description)
  end

  def set_search
    @q = Card.ransack(params[:q])
    @q.sorts = "created_at DESC" if @q.sorts.empty?
  end

  def set_tags
    @all_tags = Tag.all.distinct
  end
end
