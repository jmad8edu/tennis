class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.string :phone
      t.string :court_address
      t.string :right_left_handed

      t.timestamps null: false
    end
  end
end
