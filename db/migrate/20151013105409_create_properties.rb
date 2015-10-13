class CreateProperties < ActiveRecord::Migration
	def change
		create_table :properties do |p|
			p.string :name, null: false
			p.string :location, null: false
			p.string :availability, null: false, default: "O"
			p.belongs_to :user
			p.timestamps
		end
	end
end
