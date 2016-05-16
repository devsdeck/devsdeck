require 'rails_helper'

RSpec.describe Card, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:card) { FactoryGirl.create(:card, user: user) }

  it { should belong_to(:user) }
  
  describe '#owned_by?' do
    it 'returns true if card is owned by user provided' do
      expect(card.owned_by?(user)).to eq(true)        
    end
  end
end

