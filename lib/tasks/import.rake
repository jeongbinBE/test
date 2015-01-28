require 'csv'

namespace :db do
	task :titles => :environment do
		CSV.foreach('public/seed_data/etc_menu_title.csv') do |row|
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
		CSV.foreach('public/seed_data/etc_menu.csv') do |row|
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
=begin
		array = []
		CSV.foreach('public/seed_data/delivery_3rd.csv') do |row|
			array << row[0]
		end
		puts array.inspect
		puts Restaurant.find(1000002).inspect
		array.each do |attr|
			puts Restaurant.find(attr).inpect
		end

	r_hash = row.to_hash
	rest = Restaurant.where(id: r_hash["id"])
	rest.first.update.update_attributes(r_hash)
=end
	end
end
