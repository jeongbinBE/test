require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:jeongbin)
	end

	test "unsuccessful edit" do
		get edit_user_path(@user.username)
		assert_template 'users/edit'
		patch user_path(@user.username), user: { username: "",
																						 email: 	 "invalid@email",
																						 password: 							 "no?",
																						 password_confirmation:  "nono" }
		assert_template 'users/edit'
	end

	test "successful edit" do
		get edit_user_path(@user.username)
		update_username =  "update"
		update_email =  	 "update@email.com"
		patch user_path(@user.username), user: { username: update_username,
																						 email: 	 update_email,
																						 password: 							 "",
																						 password_confirmation:  "" }
		assert_not flash.empty?
		# username으로 redirect이므로 이전의 page와 다른 곳임.
		# assert_redirected_to user_path(@user.username)
		@user.reload
		assert_equal @user.username, update_username
		assert_equal @user.email, 	 update_email
	end

end
