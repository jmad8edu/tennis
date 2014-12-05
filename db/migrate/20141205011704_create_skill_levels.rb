class CreateSkillLevels < ActiveRecord::Migration
  def change
    create_table :skill_levels do |t|
      t.string :skill_level
      t.timestamps null: false
    end
    add_column :users, :skill_level_id, :integer
    add_index :users, :skill_level_id
  end
end
