
#------------------------------------------------------------------------
#Properties


#New properties
get '/properties/new' do
  erb :'properties/new'
end

#show property
get '/properties/:id' do
  @prop = Property.all
  @comment = Comment.all
  @property_id = params[:id]
  erb :'properties/show'
end

#create property
post '/properties' do
  id = session[:user_id]
  Property.create(name: params[:name], location: params[:location], availability: params[:availability], user_id: id)
  redirect to "/users/#{session[:user_id]}"
end

#Edit
get '/properties/:id/edit' do |id|
  if Property.authenticate?(session[:user_id], id)
    @current_property = params[:id]
    erb :'properties/edit'
  else
    "You didn't list this bro"
  end
end

#Update/Delete property
post '/properties/:id' do
  id = params[:id]
  if params[:decision] == 'edit'
    Property.find(params[:id]).update(name: params[:name], location: params[:location], availability: params[:availability])
    redirect to "users/#{session[:user_id]}"
  elsif params[:decision] == 'delete'
    Property.find(id).delete
    redirect to "/users/#{session[:user_id]}"
  end
end
