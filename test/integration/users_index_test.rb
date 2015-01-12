require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

	def setup
		@admin = users(:jeongbin)
		@non_admin = users(:haemiroo)
	end

	test "index as admin including pagination and delete links" do
		log_in_as(@admin)
		get users_path
		assert_template 'users/index'
		assert_select 'div.pagination'
		User.paginate(page: 1, per_page: 5).each do |user|
			assert_select 'a[href=?]', user_path(user.username), text: user.username
			unless user == @admin
				assert_select 'a[href=?]', user_path(user.username), text: '계정 삭제',
																 														 method: :delete
			end
		end
		assert_difference 'User.count', -1 do
			delete user_path(@non_admin.username)
		end
	end

	test "index as non-admin" do
		log_in_as(@non_admin)
		get users_path
		assert_select 'a', text: "계정 삭제", count: 0
	end
end
