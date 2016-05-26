class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :cards

  acts_as_voter

  def latest_cards
    cards.order("created_at DESC").limit(10)
  end

  def latest_likes
    card_ids = find_votes.sort_by(&:created_at).reverse.collect(&:votable_id).first(10)
    cards.where(id: card_ids)
  end

  def total_cards
    cards.size
  end

  def total_likes
    find_voted_items.size
  end
end
