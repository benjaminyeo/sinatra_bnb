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
      erb :'static/index'
    end
  else
     @error = "This username does not exist."
      erb :'static/index'
  end
end

get '/users/:id' do
  @properties = Property.all
  @user_id = session[:user_id]
  erb :'static/mainpage'
end

post '/users/logout' do
  session.clear
  redirect to "/"
end




