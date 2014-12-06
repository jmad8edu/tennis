require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    skill = SkillLevel.create(skill_level: "beginner", ntrp_rating: "wuddup")
    @user = User.new(first_name: "Example", last_name: "User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar", right_left_handed: "right",
                     phone: "555 555 5555", skill_level_id: skill.id)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.first_name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "first name should not be too long" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

  test "last name should not be too long" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "hand validation should accept valid values" do
  	valid_answers = %w[right RiGhT left LeFt]
  	valid_answers.each do |valid_answer|
      @user.right_left_handed = valid_answer
      assert @user.valid?, "#{valid_answer.inspect} should be valid"
    end
  end

  test "hand validation should reject invalid values" do
	  @user.right_left_handed = "    "
	  assert_not @user.valid?
	  @user.right_left_handed = ""
	  assert_not @user.valid?
	  @user.right_left_handed = "something"
	  assert_not @user.valid?
  end

  test "phone number should accept valid phone numbers" do
    valid_numbers = ["", "(123) 555-1234", "1231231234", "123-456-7890",
                    "123 456-7890", "1 2 3 4 5 6 7 8 9 0" ]
    valid_numbers.each do |valid_number|
      @user.phone = valid_number
      assert @user.valid?, "#{valid_number.inspect} should be valid"
    end
  end

  test "phone number should reject invalid phone numbers" do
    valid_numbers = ["123) 456-7890", "4567890", "12345678910", "12345678a", "(123) 45-67890"]
    valid_numbers.each do |valid_number|
      @user.phone = valid_number
      assert_not @user.valid?, "#{valid_number.inspect} should be invalid"
    end
  end

  test "phone numbers should be saved formatted" do
    mixed_case_phone_number = "1234567890"
    @user.phone = mixed_case_phone_number
    @user.save
    assert_equal "(123) 456-7890", @user.reload.phone
  end
end


