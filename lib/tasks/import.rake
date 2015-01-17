require 'csv'

namespace :db do
	task :rest_keys => :environment do
		CSV.foreach('public/seed_data/rest_key.csv') do |row|
			record = RestKey.new(
				:id => row[0],
				:restaurant_id => row[0],
				:cat_code => row[1],
				:name => row[2],
				:addr => row[3]
			)
			record.save!
		end
	end
end

namespace :db do
	task :restaurants => :environment do
		CSV.foreach('public/seed_data/restaurants.csv') do |row|
			record = Restaurant.new(
				:id => row[0],
				:cat => row[1],
				:sub_cat => row[2],
				:name => row[3],
				:addr => row[4],
				:phnum => row[5],
				:delivery => row[6],
				:menu_on => row[7]
			)
			record.save!
		end
	end
end