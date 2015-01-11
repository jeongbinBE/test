require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	test 'invalid signup will not change user count' do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { username: '',
															 email: 'invalid@eamil',
															 password:              "good?",
															 password_confirmation: "nogood" }
		end
		assert_template 'users/new'
	end
end
