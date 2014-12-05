class AddNtrpRatingToSkillLevels < ActiveRecord::Migration
  def change
    add_column :skill_levels, :ntrp_rating, :double
  end
end
