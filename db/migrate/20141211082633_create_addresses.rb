class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.references :addressable, polymorphic: true

      t.timestamps null: false
    end
    remove_column :users, :court_address, :string
    remove_column :matches, :location, :string
  end
end
