class Flashcard < ActiveRecord::Base
  belongs_to :user
  acts_as_votable
  paginates_per 8

 def owned_by?(owner)
   return false unless owner.is_a?(User)
   user == owner
 end

end
