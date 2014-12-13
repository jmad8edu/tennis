class User < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :skill_level
  has_one :address, as: :addressable, dependent: :destroy
  has_many :notifications_sent, class_name: "Notification", foreign_key: "sender_id"
  has_many :notifications_received, class_name: "Notification", foreign_key: "receiver_id"
  has_many :notifications_unread, -> {where notified: false}, class_name: "Notification", foreign_key: "receiver_id"
  has_many :wins, class_name: "Result", foreign_key: "winner_id"
  has_many :losses, class_name: "Result", foreign_key: "loser_id"
  has_many :inviter_matches, class_name: "Match", foreign_key: "inviter_id"
  has_many :invitee_matches, class_name: "Match", foreign_key: "invitee_id"
  
  before_save :format_fields
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, allow_blank: true
  has_secure_password
  validate :phone_number_check
  validate :skill_level_check
  validate :right_left_handed_check
  accepts_nested_attributes_for :address

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

  def phone_number_check
    if self.phone != nil && self.phone != ''
      begin
        number = self.phone.gsub(/\s|\(|\)|-/, "")
        number_to_phone(number, area_code: true, raise: true)

        re = /(((\(\s*(\d\s*){3}\))|((\d\s*){3}))\s*-?\s*(\d\s*){3}\s*-?\s*(\d\s*){4})/
        if (self.phone =~ re) == nil
          errors.add(:phone, "must be in format (xxx) xxx-xxxx")
        elsif number.size != 10
          errors.add(:phone, "must be 10 digits long")
        end
      rescue
        errors.add(:phone, "must be in format (xxx) xxx-xxxx")
      end
    end
  end

  def format_fields
    # format email
    self.email = email.downcase 

    # format phone
    if self.phone != nil && self.phone != ''
      self.phone = number_to_phone(phone.gsub(/\s|\(|\)|-/, ""), area_code: true )
    end
  end

  def name
    self.first_name.capitalize + " " + self.last_name.capitalize
  end

  def matches
    inviter_matches + invitee_matches
  end
end
