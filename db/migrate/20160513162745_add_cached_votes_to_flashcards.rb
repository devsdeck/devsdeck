class AddCachedVotesToFlashcards < ActiveRecord::Migration
  def change
    add_column :flashcards, :cached_votes_totall, :integer, default: 0
  end
end
