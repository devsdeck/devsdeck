class AddRemainingCachedVotesFieldsAndIndexes < ActiveRecord::Migration
  def up
    add_column :cards, :cached_votes_score, :integer, default: 0
    add_column :cards, :cached_votes_up, :integer, default: 0
    add_column :cards, :cached_votes_down, :integer, default: 0
    add_column :cards, :cached_weighted_score, :integer, :default => 0
    add_column :cards, :cached_weighted_total, :integer, :default => 0
    add_column :cards, :cached_weighted_average, :float, :default => 0.0

    add_index  :cards, :cached_votes_score
    add_index  :cards, :cached_votes_up
    add_index  :cards, :cached_votes_down
    add_index  :cards, :cached_weighted_score
    add_index  :cards, :cached_weighted_total
    add_index  :cards, :cached_weighted_average
    add_index  :cards, :cached_votes_total

    Card.find_each(&:update_cached_votes)
  end

  def down
    remove_column :cards, :cached_votes_score
    remove_column :cards, :cached_votes_up
    remove_column :cards, :cached_votes_down
    remove_column :cards, :cached_weighted_score
    remove_column :cards, :cached_weighted_total
    remove_column :cards, :cached_weighted_average
  end
end
