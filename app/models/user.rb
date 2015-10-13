class User < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
  has_many :properties
  has_many :comments
  has_many :bookings
  validates :username, uniqueness: true
  validates :password, length: { in: 4..10 }


  def self.authenticate?(username, password)
    user = User.find_by(username: username)
    user.password == password
  end

  def self.exist?(username)
    return true if User.find_by(username: username)
  end
end
