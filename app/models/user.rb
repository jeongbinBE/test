class User < ActiveRecord::Base

	# before save func.
	before_save { self.username = username.downcase }
	before_save { self.email = email.downcase }
	
	# Basic validations
	validates :username, 
						:presence => { :message => "MenuMap에서 사용하실 아이디를 적어주세요."},
						:length   => { :minimum => 3, :maximum => 25,
													 :too_short => "3자 이상의 아이디를 사용해주세요.",
													 :too_long => "25자 이하의 아이디만 가능합니다." },
						:uniqueness => { :case_sensitive => false,
														 :message => "이미 사용중인 아이디입니다." }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,
						:presence => { :message => "로그인과 회원가입에 사용하실 이메일을 적어주세요."},
						:format => { :with    => VALID_EMAIL_REGEX,
												 :message => "이메일 형식이 올바르지 않습니다." },
						:uniqueness => { :case_sensitive => false, 
														 :message => "이미 사용중인 이메일입니다." }
end
