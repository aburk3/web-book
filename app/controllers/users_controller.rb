class UsersController < ApplicationController

  get '/users/:slug' do
    uniq_tags
     @user = User.find_by_slug(params[:slug])
     erb :'users/show'
   end

  get '/signup' do
     if !logged_in?
       erb :'users/create_user'
     else
       redirect to '/websites'
     end
   end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    elsif params[:password] != params[:passwordverify]
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/websites'
    end
  end

  get '/login' do
    if !logged_in?
      redirect to '/'
    else
      redirect '/websites'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
   if user && user.authenticate(params[:password])
     session[:user_id] = user.id
     redirect "/websites"
   else
     redirect to '/signup'
   end
 end

 get '/logout' do
   uniq_tags
   if logged_in?
     session.destroy
     redirect to '/login'
   else
     redirect to '/'
   end
  end
end
