# == Schema Information
#
# Table name: cards
#
#  id                      :integer          not null, primary key
#  name                    :string
#  description             :text
#  user_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#

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
