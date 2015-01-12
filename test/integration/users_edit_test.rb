require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:jeongbin)
	end

	test "unsuccessful edit" do
		get edit_user_path(@user.username)
		assert_template 'users/edit'
		post edit_user_path(@user.username), user: { name: "",
																								 email: "invalid",
																								 password:              "no",
																								 password_confirmation: "go"}
		assert_template 'users/edit'
	end

#	test "successful edit w/o password change" do
#		get edit_user_path(@user.username)
#		assert_template 'users/edit'
#		new_username = "gogotest"
#		new_email    = "gogoemail"
#		post edit_user_path(@user.username), user: { name:      new_username,
#																								 email:     new_email,
#																								 password:              "",
#																								 password_confirmation: ""}
		#assert_not flash.empty?
		#assert_redirected_to user_path(@user.username)
		#@user.reload
		#assert_equal @user.username, new_username
		#assert_equal @user.email,    new_email
	end
end
