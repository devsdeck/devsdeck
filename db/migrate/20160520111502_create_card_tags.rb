class CreateCardTags < ActiveRecord::Migration
  def change
    create_table :card_tags do |t|
      t.references :card, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
