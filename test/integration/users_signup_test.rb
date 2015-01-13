require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	def setup
		ActionMailer::Base.deliveries.clear
	end

	test 'Invalid signup' do
		get signup_path
		assert_no_difference 'User.count' do
			post signup_path, user: { username: '',
															  email: 'invalid@eamil',
															  password:              "good?",
															  password_confirmation: "nogood" }
		end
		assert_template 'users/signup'
	end

	test 'Valid signup w/ account activation' do
		get signup_path
		assert_difference 'User.count', 1 do
			post signup_path, user: { username: 'validman', 
															  email: 		'valid@eamil.com',
															  password:              "goodpass",
															  password_confirmation: "goodpass" }
		end
		assert_equal 1, ActionMailer::Base.deliveries.size
		user = assigns(:user)
		assert_not user.activated?
		# Try to log in before activation.
		log_in_as(user)
		assert_not is_logged_in?
		# Invalid activation token
		get edit_account_activation_path("nono")
		assert_not is_logged_in?
		# Valid token, wrong email
		get edit_account_activation_path(user.activation_token, email: "wrong mail")
		assert_not is_logged_in?
		# Valid activation
		get edit_account_activation_path(user.activation_token, email: user.email)
		assert is_logged_in?
		follow_redirect!
		assert_template 'users/show'
		assert_not flash.empty?
		assert is_logged_in?
	end
end
