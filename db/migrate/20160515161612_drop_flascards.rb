class DropFlascards < ActiveRecord::Migration
  def change
  	drop_table :flashcards
  end
end
