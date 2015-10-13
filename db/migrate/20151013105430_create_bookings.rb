class CreateBookings < ActiveRecord::Migration
	def change
		create_table :bookings do |b|
			b.date :date, null: false
			b.belongs_to :user
			b.belongs_to :property
			b.timestamps
		end
	end
end
