class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :winner_id, null: false, index: true
      t.integer :loser_id, null: false, index: true
      t.string :score, null: false

      t.timestamps null: false
    end
  end
end
