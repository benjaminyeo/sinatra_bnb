class Comment < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
  belongs_to :property
  belongs_to :user
end
