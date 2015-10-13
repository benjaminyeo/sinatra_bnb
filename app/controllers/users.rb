#New User
get '/users/new' do
  erb :'users/new'
end

#Create user
post '/users' do
  @user = User.create(username: params[:username], password: params[:password])
  @username_error = @user.errors[:username].any?
  @password_error = @user.errors[:password].any?

  if @username_error and @password_error
    existing = params[:username]
    @error_message = "Username '#{existing}' already exist, please try another.Password must be 4 to 10 characters long"
    erb :'users/error'
  else if @username_error
         @error_message = "Username '#{existing}' already exist, please try another."
         erb :'users/error'

       else if @password_error
              @error_message = "password must be 4 to 10 characters long"
              erb :'users/error'
            else
              @message = "Thank you for signing up, you can now log in."
              redirect to '/'
            end
       end
  end
end

post '/session' do
  if User.exist?(params[:username])
    if User.authenticate?(params[:username], params[:password])
      session[:user_id] = User.find_by(username: params[:username]).id
      redirect to "/users/#{session[:user_id]}"
    else
      @error = 'Invalid password'
      "Incorrect Password"
    end
  else
    @nonexist_message = "This username does not exist."
    erb :'/'
  end
end

get '/users/:id' do
  @properties = Property.all
  erb :'static/mainpage'
end

post '/users/logout' do
  session.clear
  redirect to "/"
end


#------------------------------------------------------------------------
#Properties


#New properties
get '/properties/new' do
  erb :'properties/new'
end

#show property
get '/properties/:id' do
  @prop = Property.all
  erb :'properties/show'
end



#create property
post '/properties' do
  id = session[:user_id]
  Property.create(name: params[:name], location: params[:location], availability: params[:availability], user_id: id)
  redirect to "/users/#{session[:user_id]}"
end

#Edit
get '/properties/:id/edit' do
  # if Property.authenticate?(session[:user_id], id)
  @current_property = params[:id]
  erb :'properties/edit'
  # else
  #   "You didn't list this bro"
end

#Update
post '/properties/:id' do
  id = params[:id]
  byebug
  if params[:decision] == 'edit'
      Property.find(params[:id]).update(params[:property])
      redirect to "/properties/#{params[:id]}"
  elsif params[:decision] == 'delete'
    Post.find(id).delete
    redirect to '/'
  end
end



#-------------------------------------------------------------------------------
#Booking
get '/bookings/new' do
  erb :'bookings/new'
end

get '/bookings/show' do
  erb :'bookings/mybooking'
end
