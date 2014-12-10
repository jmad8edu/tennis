class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :inviter_id, null: false, index: true
      t.integer :invitee_id, null: false, index: true
      t.boolean :inviter_accepted, default: true
      t.boolean :invitee_accepted
      t.datetime :scheduled_date, null: false
      t.string :location
      t.integer :result_id

      t.timestamps null: false
    end
  end
end
