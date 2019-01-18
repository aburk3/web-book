class TagsController < ApplicationController

  get '/tags/:id' do

    if logged_in?
      @tag = Tag.find_by_id(params[:id])
      @websites = []
      @tag.websites.each do |website|
        if website.user == current_user
          @websites << website
        end
      end
      erb :'tags/show_tag'
    else
      redirect to '/login'
    end
  end

  post '/tags' do
    redirect to "/tags/#{params[:dropdown]}"
  end

end
