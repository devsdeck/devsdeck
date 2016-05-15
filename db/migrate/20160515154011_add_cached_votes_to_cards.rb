class AddCachedVotesToCards < ActiveRecord::Migration
  def change
  	add_column :cards, :cached_votes_totall, :integer, default: 0
  end
end
