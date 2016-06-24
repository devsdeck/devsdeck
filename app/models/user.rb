# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE)
#  name                   :string
#  description            :text
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  has_many :cards
  validates :username, presence: true, uniqueness: true, case_sensitive: false

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
