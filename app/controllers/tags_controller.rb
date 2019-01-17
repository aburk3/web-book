class TagsController < ApplicationController

  get '/tags/:id' do

    if logged_in?
      @website = current_user.websites.find_by_id(params[:id])
      @tags = current_user.websites.all.each do |website|
        website.tag
      end
      binding.pry
      ###########################################
      #  ONLY SHOW CURRENT USERS WEBSITES/tags  #
      ###########################################
      erb :'tags/show_tag'
    else
      redirect to '/login'
    end
  end

  get '/mytags/:id' do
    uniq_tags
    if logged_in?
      @tag = Tag.where(:id => params[:id])
      @website = @tag.first.websites.first
      @tags = []

      @tag_instances.each do |tag|
        if tag.websites.any? && tag.id == params[:id].to_i
          @tags << tag
        end
      end
      erb :'tags/show_tag'
    else
      redirect to '/login'
    end
  end

  post '/tags' do
    redirect to "/mytags/#{params[:dropdown]}"
  end

end
