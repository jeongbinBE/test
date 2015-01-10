require 'test_helper'

class UserTest < ActiveSupport::TestCase
	
	def setup
		@user = User.new(username: "TestUser", email: "TestUser@menumap.co.kr")
	end

	test "user should be valid" do
		assert @user.valid?
	end

	# Username
	test "username should be present" do
		@user.username = "  "
		assert_not @user.valid?
	end

	test "username should not be too short" do
		@user.username = "aa"
		assert_not @user.valid?
	end

	test "username should not be too long" do
		@user.username = "a" * 26 
		assert_not @user.valid?
	end

	test "username sholud be unique" do
		duplicate = @user.dup
		duplicate.email = "temp@menumap.co.kr"
		duplicate.username.upcase!
		@user.save
		assert_not duplicate.valid?
	end

	# Email
	test "email should be present" do
		@user.email = ""
		assert_not @user.valid?
	end

  test "here are valid addresses" do
    valid_addresses = %w[test@valuemap.com test@menumap.co.kr USER@google.COM 
												 A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "here are invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

	test "email sholud be unique" do
		duplicate = @user.dup
		duplicate.username = "gosss"
		duplicate.email.upcase!
		@user.save
		assert_not duplicate.valid?
	end

end
