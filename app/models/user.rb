class User < ActiveRecord::Base
  has_one :skill_level
  before_save { self.email = email.downcase }
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validate :right_left_handed_check
  validate :skill_level_check
  validates :password, length: { minimum: 6 }
  has_secure_password

  def right_left_handed_check
  	if self.right_left_handed == nil || 
      (self.right_left_handed.downcase != "right" && self.right_left_handed.downcase != "left")
    	errors.add(:right_left_handed, "must be specified")
    end
  end

  def skill_level_check
    if self.skill_level_id == nil || self.skill_level_id == ""
      errors.add(:skill_level, "must be specified")
    else
      skill_levels = SkillLevel.all
      id_is_valid = false
      skill_levels.each do |skill_level|
        if skill_level.id == self.skill_level_id
          id_is_valid = true
          break
        end
      end
      if !id_is_valid
        errors.add(:skill_level, "must be a valid skill level")
      end
    end
  end

  def name
    self.first_name + " " + self.last_name
  end
end
