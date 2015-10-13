class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |user|
			user.string :username, null: false
			user.string :password, null: false
		end
	end
end
