class TagsController < ApplicationController

  get '/tags/:id' do
    uniq_tags
    if logged_in?
      @website = Website.find_by_id(params[:id])

      @tag = Tag.where(:content => @website.tag.content)
      ######################################
      #  ONLY SHOW CURRENT USERS WEBSITES  #
      ######################################
      if @website && @website.user == current_user
        @tags = []
        
        @tag_instances.each do |tag|
          if tag.websites.any? && tag.content == @tag.last.content
            @tags << tag
          end
        end
        erb :'tags/show_tag'
      else
        redirect to '/websites'
      end
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
