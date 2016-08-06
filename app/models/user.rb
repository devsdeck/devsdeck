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
#  provider               :string
#  uid                    :string
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable
  devise :omniauthable, omniauth_providers: [:github]

  has_many :cards
  validates :username, presence: true, uniqueness: true, case_sensitive: false

  acts_as_voter

  def latest_cards
    all_added_cards.limit(10)
  end

  def latest_likes
    all_liked_cards.limit(10)
  end

  def all_added_cards
    cards.includes(:tags).order("created_at DESC")
  end

  def all_liked_cards
    Card.includes(:tags).joins("INNER JOIN votes on votes.votable_id = cards.id")
      .where("votes.voter_id = #{id}")
      .order("votes.created_at DESC")
  end

  def total_cards
    cards.size
  end

  def total_likes
    find_voted_items.size
  end

  def self.from_github_omniauth(auth)
    user = find_or_initialize_by(email: auth.info.email) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.username = auth.info.nickname
      user.skip_confirmation! if user.new_record?
    end

    if user.provider.blank? || user.uid.blank?
      user.provider = auth.provider
      user.uid = auth.uid
      user.save
    end

    user
  end
end
