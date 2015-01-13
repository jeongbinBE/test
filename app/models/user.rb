class User < ActiveRecord::Base
	
	# attributes
	attr_accessor :remember_token, :activation_token

	# Callbacks
	before_save 	:downcase_email
	before_create :create_activation_digest
	
	# Basic validations
	validates :username, 
						:presence		=> { :message => "MenuMap에서 사용하실 아이디를 적어주세요."},
						:length			=> { :minimum => 3, :maximum => 25,
														 :too_short => "3자 이상의 아이디를 사용해주세요.",
														 :too_long => "25자 이하의 아이디만 가능합니다." },
						:uniqueness => { :case_sensitive => false,
														 :message => "이미 사용중인 아이디입니다." }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email,
						:presence		=> { :message => "로그인과 회원가입에 사용하실 이메일을 적어주세요."},
						:format			=> { :with    => VALID_EMAIL_REGEX,
													 	 :message => "이메일 형식이 올바르지 않습니다." },
						:uniqueness => { :case_sensitive => false, 
														 :message => "이미 사용중인 이메일입니다." }
		
	has_secure_password
	validates :password,
						:presence		=> { :message => "비밀번호를 입력해주세요."},
						:length     => { :minimum   => 8, :maximum => 25,
														 :too_short => "비밀번호는 8자 이상으로 해주세요.",
														 :too_long  => "비밀번호는 25자 이하로 설정해주세요."},
						:allow_blank => true

	class << self
		# Hash digest
		def digest(string)
			cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																										BCrypt::Engine.cost
			BCrypt::Password.create(string, cost: cost)
		end

		# Returns a random token
		def new_token
			SecureRandom.urlsafe_base64
		end
	end

	# Remembers a user in a database for use in persistent sessions.
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	# Forgets a user.
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Activates an account.
	def activate
		update_attribute(:activated,    true)
		update_attribute(:activated_at, Time.now)
	end

	def send_activation_email
		UserMailer.account_activation(self).deliver
	end

	private
		
		def downcase_email
			self.email = email.downcase
		end

		def create_activation_digest
			self.activation_token  = User.new_token
			self.activation_digest = User.digest(activation_token)
		end
end
