require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  helpers do
    def current_user
      @current_user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
    end

    def logged_in?
     !!current_user
    end

    def uniq_tags
      # tags = []
      # Tag.all.each do |tag|
      #   unless tags.include?(tag.id && tag.content.downcase)
      #     tags << tag.content.downcase
      #     tags << tag.id
      #   end
      # end
      @tag_instances = []
      contents = []
      Tag.all.each do |tag|
        unless contents.include?(tag.content)
          contents << tag.content
          @tag_instances << tag
        end
      end
    end
  end

end
