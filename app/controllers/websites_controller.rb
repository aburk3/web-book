class WebsitesController < ApplicationController
  get '/websites' do
    if logged_in?
      @websites = Website.all
      erb :'websites/websites'
    else
      redirect to '/login'
    end
  end

  get '/websites/new' do
    if logged_in?
      erb :'websites/new'
    else
      redirect to '/login'
    end
  end

  post '/websites' do
    binding.pry
    if logged_in?
      if params[:content] == ""
        redirect to "/websites/new"
      else
        @website = current_user.websites.build(content: params[:content])
        if @website.save
          redirect to "/websites/#{@website.id}"
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
          if @website.update(content: params[:content])
            redirect to "/websites/#{@website.id}"
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

end
