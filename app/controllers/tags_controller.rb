class TagsController < ApplicationController

  get '/tags/:id' do
    uniq_tags
    if logged_in?
      @website = Website.find_by_id(params[:id])
      @tag
      @tag = Tag.where(:content => @website.tag.content)

      ######################################
      #  ONLY SHOW CURRENT USERS WEBSITES  #
      ######################################
      def my_tag
        current_user.tags.include?("#{@tag}")
      end
      binding.pry
      if @website && @website.user == current_user
        @tags = []
        Tag.all.each do |tag|
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

  post '/tags' do
    binding.pry
  end

end
