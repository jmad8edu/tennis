class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  # validate :right_left_handed_check

  def right_left_handed_check
  	if right_left_handed != "right" || right_left_handed != "left" || right_left_handed != "" || right_left_handed != nil
    	errors.add(:right_left_handed, "must be 'right' or 'left'")
    end
  end

  def name
    self.first_name + " " + self.last_name
  end
end
