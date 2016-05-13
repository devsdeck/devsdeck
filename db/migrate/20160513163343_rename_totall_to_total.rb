class RenameTotallToTotal < ActiveRecord::Migration
  def change
    rename_column :flashcards, :cached_votes_totall, :cached_votes_total
  end
end
