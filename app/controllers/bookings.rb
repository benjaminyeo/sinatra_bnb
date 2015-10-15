#------------------------------------------------------------------------------
#bookings

#show mybookings
get '/users/:user_id/mybookings' do
  @user_id = session[:user_id]
  @mybookings = User.find(@user_id).bookings.all
  erb :'bookings/show'
end


#new bookings
get '/users/:user_id/property/:property_id/bookings/new' do
  @user_id = params[:user_id]
  @property_id = params[:property_id]
  erb :'bookings/new'
end

#create bookings
post '/users/:user_id/property/:property_id/bookings/create' do
  @user_id = session[:user_id]
  @property_id = params[:property_id]
  if params[:message]== "" then @message = "no message" else @message = params[:message] end
  Booking.create(date: Time.now, message: @message, user_id: @user_id, property_id: @property_id)
  #you should make a model for this
  Booking.update_availability(params[:decision], @property_id)
  redirect to "/users/#{session[:user_id]}"
end

#edit bookings
get '/users/:user_id/property/:property_id/bookings/:id/edit' do
  @current_booking_id = params[:id]
  @current_booking = Booking.find(@current_booking_id)
  erb :'bookings/edit'
end

#edit bookings/booking message
post '/users/:user_id/property/:property_id/bookings/:id' do
  @current_booking = Booking.find(params[:id])
  @property_id = params[:property_id]
  if params[:message]== "" then @message = "no message" else @message = params[:message] end
  if params[:decision] == 'edit message'
    @current_booking.update(message: @message)
    redirect to "/users/#{params[:user_id]}/mybookings"
  elsif params[:decision] == 'delete'
    @current_booking.delete
    Booking.update_availability(params[:decision], @property_id)
    redirect to "/users/#{params[:user_id]}/mybookings"
  end
end