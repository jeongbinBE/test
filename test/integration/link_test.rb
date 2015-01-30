require 'test_helper'

class NavigationLinkTest < ActionDispatch::IntegrationTest

	test "Header navigation has the right link path" do
		get root_path
		assert_template 'home/index'
		assert_select 'a[href=?]', root_path, count: 2
		assert_select 'a[href=?]', manual_path
		assert_select 'a[href=?]', help_path
		assert_select 'a[href=?]', search_path
		assert_select 'a[href=?]', signup_path
		assert_select 'a[href=?]', login_path 
	end

	test "Brandpage should have adequate path" do
		get root_path
		assert_select 'a[href=?]', search_path, count: 4
	end
end
