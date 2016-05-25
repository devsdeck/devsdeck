require 'rails_helper'

RSpec.describe Card, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:card) { FactoryGirl.create(:card, user: user) }

  it { should belong_to(:user) }
  it { should have_many(:card_tags) }
  it { should have_many(:tags) }
  
  describe '#owned_by?' do
    it 'should return true if card is owned by user provided' do
      expect(card.owned_by?(user)).to eq(true)        
    end
  end

  describe '#like_created_at_by' do
    it 'should return created_at of vote on a card' do
      card.liked_by(user)

      expect(card.like_created_at_by(user))
        .to eq(card.get_upvotes.find_by(voter: user).created_at)
    end
  end
end

