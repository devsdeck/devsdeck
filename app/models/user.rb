class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  has_many :cards
  validates :username, presence: true, uniqueness: true

  acts_as_voter

  def latest_cards
    cards.order("created_at DESC").limit(10)
  end

  def latest_likes
    find_votes.sort_by(&:created_at).reverse.first(10).map(&:votable)
  end

  def total_cards
    cards.size
  end

  def total_likes
    find_voted_items.size
  end
end
