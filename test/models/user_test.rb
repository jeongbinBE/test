require 'test_helper'

class UserTest < ActiveSupport::TestCase
	
	def setup
		@user = User.new(username: "TestUser", email: "TestUser@menumap.co.kr",
										 password: "testpass", password_confirmation: "testpass")
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

  test "username should be saved as lower-case" do
    mixed_case = "TestUser01"
    @user.username = mixed_case
    @user.save
    assert_equal mixed_case.downcase, @user.reload.username
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
    invalid_addresses = %w[comma@email,com no_at_mark.org no.com@example.
                           underscore@bar_baz.com plus@br+bz.com dotdot@email..com]
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

  test "email should be saved as lower-case" do
    mixed_case = "TestEmaiL@MenuMap.co.kr"
    @user.email = mixed_case
    @user.save
    assert_equal mixed_case.downcase, @user.reload.email
  end

	# Password

	test "password should not be too short" do
		@user.password = @user.password_confirmation = "a" * 7
		assert_not @user.valid?
	end

	test "password should not be too long" do
		@user.password = @user.password_confirmation = "a" * 26
		assert_not @user.valid?
	end
end
