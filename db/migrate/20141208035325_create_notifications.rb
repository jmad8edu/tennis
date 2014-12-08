class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notification_types do |t|
      t.string :description, null: false

      t.timestamps null: false
    end

    create_table :notifications do |t|
      t.integer :receiver_id, null: false, index: true
      t.integer :sender_id, null: false, index: true
      t.references :notification_type, null: false, index: true
      t.integer :arg_id, null: false
      t.boolean :notified, null: false, default: false

      t.timestamps null: false
    end
  end
end
