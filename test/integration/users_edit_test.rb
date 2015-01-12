require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:jeongbin)
	end

	test "unsuccessful edit" do
		log_in_as(@user)
		get edit_user_path(@user.username)
		assert_template 'users/edit'
		patch user_path(@user.username), user: { username: "",
																						 email: 	 "invalid@email",
																						 password: 							 "no?",
																						 password_confirmation:  "nono" }
		assert_template 'users/edit'
	end

	test "successful edit w/ route back to the intended page" do
		get edit_user_path(@user.username)
		log_in_as(@user)
		assert_redirected_to edit_user_path(@user.username)
		update_username =  "update_test_username"
		update_email =  	 "update_test_email@email.com"
		patch user_path(@user.username), user: { username: update_username,
																						 email: 	 update_email,
																						 password: 							 "",
																						 password_confirmation:  "" }
		assert_not flash.empty?
		@user.reload   # username is changed
		assert_redirected_to user_path(@user.username)
		assert_equal @user.username, update_username
		assert_equal @user.email, 	 update_email
	end

end
