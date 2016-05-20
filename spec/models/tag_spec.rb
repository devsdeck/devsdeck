require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should have_many(:card_tags) }
  it { should have_many(:cards) }
end
