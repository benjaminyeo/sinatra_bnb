#----------------------------------------------------------------------------------
#Reviews
get '/comments/new' do
  erb :'comments/new'
end

#new comments
post '/users/:user_id/property/:property_id/comments' do
  Comment.create(body: params[:body], property_id: params[:property_id], user_id: params[:user_id] )
  redirect to "properties/#{params[:property_id]}"
end

get '/comments/show' do
  erb :'comments/mybooking'
end

get '/properties/comments/:id/edit' do |id|
  @current_comment_id = id
  @current_comment = Comment.find(id)
  erb :'comments/edit'
end

#edit comments/reviews
post '/users/:user_id/property/:property_id/comments/:id' do
  @current_comment = Comment.find(params[:id])
  if params[:decision] == 'edit'
    @current_comment.update(body: params[:body])
    redirect to "/properties/#{params[:property_id]}"
  elsif params[:decision] == 'delete'
    @current_comment.delete
    redirect to "/properties/#{params[:property_id]}"
  end
end

