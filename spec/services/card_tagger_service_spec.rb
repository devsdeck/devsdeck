require 'rails_helper'

RSpec.describe CardTaggerService do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:card) { FactoryGirl.create(:card, user: user) }
  let!(:tag) { FactoryGirl.create(:tag) }

  let(:tagger) { CardTaggerService.new(card, [tag.name, 'new tag']) }

  describe '#perform' do
    it 'tags the card' do
      tagger.perform
      expect(card.tags.count).to eq(2)
    end
  end
end
