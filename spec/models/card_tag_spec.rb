require 'rails_helper'

RSpec.describe CardTag, type: :model do
  it { should belong_to(:tag) }
  it { should belong_to(:card) }
end
