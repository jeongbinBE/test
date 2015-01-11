require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

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

	test 'Valid signup' do
		get signup_path
		assert_difference 'User.count', 1 do
			post_via_redirect signup_path, user: { username: 'validman',
																						email: 'valid@eamil.com',
																				 	  password:              "goodpass",
																						password_confirmation: "goodpass" }
		end
		assert_template 'users/show'
		assert_not flash.empty?
	end
end
