class CreateComments < ActiveRecord::Migration
	def change
		create_table :comments do |c|
			c.string :body, null: false
			c.belongs_to :property
			c.belongs_to :user
			c.timestamps
		end
	end
end
