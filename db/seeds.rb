# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: 'Jeongbin', 
						email: 		'jeongbin@menumap.co.kr', 
						password: 						 'testpass', 
						password_confirmation: 'testpass',
						admin: 				true,
						activated: 		true,
						activated_at: Time.zone.now)


29.times do |n|
	username = Faker::Name.name
	email = "testversion-#{n+1}@menumap.co.kr"
	password = "password"
	User.create!(username:		username,
							 email: 			email,
							 password:							password,
							 password_confirmation: password,
							 activated: 	 true,
							 activated_at: Time.zone.now)
end
