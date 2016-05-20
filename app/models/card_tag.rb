class CardTag < ActiveRecord::Base
  belongs_to :card
  belongs_to :tag
end
