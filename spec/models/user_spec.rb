require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryGirl.create(:user) }

  it { should have_many(:cards) }

  describe '#latest_cards' do
    it 'should display the lastet cards in a DESC order' do
      FactoryGirl.create(:card, name: 'card_one', user: user)
      FactoryGirl.create(:card, name: 'card_two', user: user)

      expect(user.latest_cards.first.name).to eq('card_two')
    end
  end

  describe '#latest_likes' do
    it 'should display the lastet cards user liked in a DESC order' do
      card1 = FactoryGirl.create(:card, name: 'card_one', user: user)
      card2 = FactoryGirl.create(:card, name: 'card_two', user: user)
      card1.liked_by(user)
      card2.liked_by(user)

      expect(user.latest_likes.first.name).to eq('card_two')
    end
  end

  describe '#total_cards' do
    it 'should return the total number of cards by the user' do
      FactoryGirl.create(:card, name: 'card_one', user: user)
      FactoryGirl.create(:card, name: 'card_two', user: user)

      expect(user.total_cards).to eq(2)
    end
  end

  describe '#total_likes' do
    it 'should return the total number of cards liked by the user' do
      card1 = FactoryGirl.create(:card, name: 'card_one', user: user)
      card2 = FactoryGirl.create(:card, name: 'card_two', user: user)
      card1.liked_by(user)
      card2.liked_by(user)

      expect(user.total_likes).to eq(2)
    end
  end
end
