require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if logged_in?
      redirect to '/websites'
    else
      erb :index
    end
  end

  helpers do
    def current_user
      @current_user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
    end

    def logged_in?
     !!current_user
    end

    def redirect_if_not_logged_in
      redirect to '/' unless logged_in?
    end

  end
end
