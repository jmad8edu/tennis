class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.integer :sender_id
    	t.string :message
    	t.references :messagable, polymorphic: true

    	t.timestamps null: false
    end
  end
end