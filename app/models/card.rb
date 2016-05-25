class Card < ActiveRecord::Base
  has_many :card_tags
  has_many :tags, through: :card_tags
  belongs_to :user

  validates_presence_of :name

  acts_as_votable
  paginates_per 8

  def owned_by?(owner)
    return false unless owner.is_a?(User)
    user == owner
  end

  def like_created_at_by(user)
    get_upvotes.find_by(voter: user).try(:created_at)
  end
end
