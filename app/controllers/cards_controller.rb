class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy, :like]
  before_filter :set_search
  before_action :authenticate_user!, except: :index

  load_and_authorize_resource

  def index
    @cards = @q.result.includes(:user).page params[:page]
    respond_to do |format|
      format.html
      format.js
    end
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

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    return unless current_user
    @card.upvote_by current_user
    respond_to do |format|
      format.js
    end
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
    @q.sorts = 'created_at desc' if @q.sorts.empty?
  end
end
