class Property < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
  belongs_to :user
  has_many :comments
  has_many :bookings

  def self.authenticate? (current_userid, current_propertyid)
      return true if current_userid.to_i == Property.find(current_propertyid).user_id
      return false
    end
  end
