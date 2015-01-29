require 'csv'

# Franchises

namespace :db do
	task :fn => :environment do
		CSV.foreach('public/seed_data/franchises_20150129.csv') do |row|
			record = Franchise.new(
				:fn => row[0],
				:restaurant => row[1]
			)
			record.save!
		end
	end
end

namespace :db do
	task :f_titles => :environment do
		CSV.foreach('public/seed_data/titles_on_franchises_20150129.csv') do |row|
			row[0].to_i == 0 ? n = 10101 : n = row[0]
			Franchise.where(fn: n).each do |r|
				record = Restaurant.find(r.restaurant)
				record.menu_titles.create(
					title_name: row[2], # row[1]은 title_order이므로 menus에서 필요.
					title_info: row[3]
				)
			end
		end
	end
end

namespace :db do
	task :f_menus => :environment do
		CSV.foreach('public/seed_data/menus_on_franchises_20150129.csv') do |row|
			row[0].to_i == 0 ? n = 10101 : n = row[0]
			row[1].to_i == 0 ? m = 0 : m = row[1].to_i - 1 # array 요소 0 부터 시작
			Franchise.where(fn: n).each do |r|
				Restaurant.find(r.restaurant).menu_titles[m].menus.create(
					menu_name: row[2],
					menu_side_info: row[3],
					menu_price: row[4],
					menu_info: row[5]
				)
			end
		end
	end
end

# Menu and MenuTitle

namespace :db do
	task :titles => :environment do
		CSV.foreach('public/seed_data/seodaemoon_menu_title.csv') do |row|
			record = MenuTitle.new(
				:restaurant_id => row[0],
				:id => row[1],
				:title_name => row[2],
				:title_info => row[3]
			)
			record.save!
		end
	end
end

namespace :db do
	task :menus => :environment do
		CSV.foreach('public/seed_data/seodaemoon_menu.csv') do |row|
			record = Menu.new(
				menu_title_id: row[0],
				id: row[1],
				menu_name: row[2],
				menu_side_info: row[3],
				menu_price: row[4],
				menu_info: row[5]
			)
			record.save!
		end
	end
end

# Category and SubCategory

namespace :db do
	task :categories => :environment do
		CSV.foreach('public/seed_data/categories_20150128.csv') do |row|
			record = Category.new(
				:id => row[0],
				:name => row[1]
			)
			record.save!
		end
	end
end

namespace :db do
	task :sub_categories => :environment do
		CSV.foreach('public/seed_data/sub_categories.csv') do |row|
			record = SubCategory.new(
				:category_id => row[0],
				:name => row[1],
				:cat_code => row[2]
			)
			record.save!
		end
	end
end

# Restaurant and RestKey

namespace :db do
	task :rest_keys => :environment do
		CSV.foreach('public/seed_data/rest_keys_20150128.csv') do |row|
			record = RestKey.new(
				:id => row[0],
				:restaurant_id => row[0],
				:cat_code => row[1],
				:name => row[2],
				:addr => row[3],
				:delivery => row[4]
			)
			record.save!
		end
	end
end

namespace :db do
	task :restaurants => :environment do
		CSV.foreach('public/seed_data/restaurants_20150128.csv') do |row|
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

namespace :db do
	task :delivery => :environment do
		CSV.foreach('public/seed_data/delivery_3rd.csv', converters: :numeric) do |row|
			#n = parse(row[0])
			n = row[0].to_i
			n = 1000001 if n == 0
			record = RestKey.find(n)
			record.update_attributes(
			#puts record.inspect
			#record.first.update_attributes(
				:delivery => row[1]
			)
			record.save!
		end
	end
end
