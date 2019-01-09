class WebsitesController < ApplicationController
  get '/websites' do
    if logged_in?
      @websites = current_user.websites
      erb :'websites/websites'
    else
      redirect to '/login'
    end
  end

  get '/websites/new' do
    tags = []
    Tag.all.each do |tag|
      tags << tag.content.downcase
    end
    
    @uniq_tags = tags.uniq

    if logged_in?
      erb :'websites/new'
    else
      redirect to '/login'
    end
  end

  post '/websites' do
    if logged_in?
      if params[:content] == ""
        redirect to "/websites/new"
      else

        @website = current_user.websites.build(content: params[:content].downcase)

        @website.tag = Tag.create(content: params[:dropdown].downcase)
        @tag = current_user.tags.build(content: params[:dropdown].downcase)

        if @website.save && @tag.save
          redirect to "/websites"
        else
          redirect to "/websites/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/websites/:id' do
    if logged_in?
      @website = Website.find_by_id(params[:id])
      erb :'websites/show_website'
    else
      redirect to '/login'
    end
  end

  get '/websites/:id/edit' do
    if logged_in?
      @website = Website.find_by_id(params[:id])
      if @website && @website.user == current_user
        erb :'websites/edit_website'
      else
        redirect to '/websites'
      end
    else
      redirect to '/login'
    end
  end

  patch '/websites/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/websites/#{params[:id]}/edit"
      else
        @website = Website.find_by_id(params[:id])
        if @website && @website.user == current_user
          if @website.update(content: params[:content]) && @website.tag.update(content:params[:dropdown])
            redirect to "/websites"
          else
            redirect to "/websites/#{@website.id}/edit"
          end
        else
          redirect to '/websites'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/websites/:id/delete' do
    if logged_in?
      @website = Website.find_by_id(params[:id])
      if @website && @website.user == current_user
        if @website.tag
          # binding.pry
          @website.delete
          @website.tag.delete
        else
          @website.delete
        end
      end
      redirect to '/websites'
    else
      redirect to '/login'
    end
  end
end
