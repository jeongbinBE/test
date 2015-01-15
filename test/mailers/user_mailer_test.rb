require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

	test "account_activation" do
		user = users(:jeongbin)
		user.activation_token = User.new_token
		mail = UserMailer.account_activation(user)
		assert_equal "MenuMap 계정을 활성화해주세요.", mail.subject
		assert_equal [user.email], mail.to
		assert_equal ["info@menumap.co.kr"],	mail.from
		assert_match user.username,						mail.body.encoded
		assert_match user.activation_token,		mail.body.encoded
		assert_match CGI::escape(user.email), mail.body.encoded
	end

	test "password reset" do
		user = users(:jeongbin)
		user.reset_token = User.new_token
		mail = UserMailer.password_reset(user)
		assert_equal "비밀번호 재설정을 위한 이메일입니다.", mail.subject
		assert_equal [user.email], mail.to
		assert_equal ["info@menumap.co.kr"],	mail.from
		assert_match user.reset_token,				mail.body.encoded
		assert_match CGI::escape(user.email), mail.body.encoded
	end
end
