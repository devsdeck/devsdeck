class RenameTotallToTotalForCards < ActiveRecord::Migration
  def change
    rename_column :cards, :cached_votes_totall, :cached_votes_total
  end
end
