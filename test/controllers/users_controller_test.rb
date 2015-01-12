require 'test_helper'

class UsersControllerTest < ActionController::TestCase

	def setup
		@user = users(:jeongbin)
		@other_user = users(:haemiroo)
	end

  test "should get signup" do
    get :signup
    assert_response :success
  end

	# make it available only to admin users.
	test "should redirect index when not logged in" do
		get :index
		assert_redirected_to login_url
	end

	test "should redirect edit when not logged in" do
		get :edit, username: @user.username
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test "should redirect update when not logged in" do
		patch :update, username: @user.username,
									 user: { username: @user.username, email: @user.email }
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test "should redirect edit when logged in as other user" do
		log_in_as(@other_user)
		get :edit, username: @user.username
		assert flash.empty?
		assert_redirected_to root_url
	end

	test "should redirect update when logged in as other user" do
		log_in_as(@other_user)
		patch :update, username: @user.username,
									 user: { username: @user.username, email: @user.email }
		assert flash.empty?
		assert_redirected_to root_url
	end

	test "redirect destroy when not logged in" do
		assert_no_difference 'User.count' do
			delete :destroy, username: @user.username
		end
		assert_redirected_to login_url
	end

	test "redirect destroy when not admin user" do
		log_in_as(@other_user)
		assert_no_difference 'User.count' do
			delete :destroy, username: @user.username
		end
		assert_redirected_to root_url
	end

	test "Not able to convert to admin user through url" do
		log_in_as(@other_user)
		assert_not @other_user.admin?
		patch :update, username: @other_user.username, user: { password: "",
																									 password_confirmation: "",
																									 admin: true }
		assert_not @other_user.reload.admin?
	end
end
