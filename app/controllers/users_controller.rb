class UsersController < ApplicationController

  get '/users/:slug' do
    redirect_if_not_logged_in

    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    redirect_if_not_logged_in
    erb :'users/create_user'
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || !params[:email].include?("@") || params[:password] == ""
      redirect to '/signup'
    elsif User.find_by(:username => params[:username]) || User.find_by(:email => params[:email])
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
    redirect_if_not_logged_in
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
    redirect_if_not_logged_in

    session.destroy
    redirect to '/login'
  end
end
