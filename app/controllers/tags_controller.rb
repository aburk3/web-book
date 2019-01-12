class TagsController < ApplicationController

  get '/tags/:id' do
    if logged_in?
      @website = Website.find_by_id(params[:id])
      @tag = Tag.where(:content => @website.tag.content)

      @tags = []
      Tag.all.each do |tag|
        if tag.websites.any? && tag.content == @tag.last.content
          @tags << tag
        end
      end

      if @website && @website.user == current_user
        erb :'tags/show_tag'
      else
        redirect to '/websites'
      end
    else
      redirect to '/login'
    end
  end

  post '/tags' do
    binding.pry
  end

end
