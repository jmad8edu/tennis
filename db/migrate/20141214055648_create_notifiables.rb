class CreateNotifiables < ActiveRecord::Migration
  def change
    remove_column :notifications, :arg_id, :integer
    add_reference :notifications, :notifiable, polymorphic: true, index: true
  end
end
