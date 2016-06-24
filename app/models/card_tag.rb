# == Schema Information
#
# Table name: card_tags
#
#  id         :integer          not null, primary key
#  card_id    :integer
#  tag_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CardTag < ActiveRecord::Base
  belongs_to :card
  belongs_to :tag
end
