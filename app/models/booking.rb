class Booking < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
  belongs_to :property
  belongs_to :user

  def self.update_availability(decision, property_id)
    #if decision is book, update property to "X"
    if decision == "Book!"
      Property.find(property_id).update(availability: "X")
    elsif decision == "delete"
      Property.find(property_id).update(availability: "O")
  end
end
end