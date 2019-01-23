class WebsitesController < ApplicationController

  get '/websites' do
    redirect_if_not_logged_in

    if params[:dropdown_tag]
      @websites = current_user.websites.where(tag_id: params[:dropdown_tag])
    else
      @websites = current_user.websites
    end
    @tags = current_user.tags
    erb :'websites/websites'
  end

  get '/websites/new' do
    redirect_if_not_logged_in

    @tags = current_user.tags
    erb :'websites/new'
  end

  post '/websites' do
    redirect_if_not_logged_in

    if params[:content] == ""
      redirect to "/websites/new"
    else
      @website = current_user.websites.build(content: params[:content].downcase)
      @website.format_url

      if params[:dropdown_tag] == ""
        params[:dropdown_tag] = "none"
      end

      ##########################################################################
      #
      # If a tag has been created previously, you must check that the new tag
      # does not already exist, otherwise, no check is necessary
      #
      if Tag.find_by(:content => params[:dropdown_tag])
        @tag = Tag.find_by(:content => params[:dropdown_tag])
        @tag.websites << @website
      else
        @website.tag = Tag.create(content: params[:dropdown_tag].downcase)
      end

      if @website.save
        redirect to "/websites"
      else
        redirect to "/websites/new"
      end
    end
  end

  get '/websites/:id/edit' do
    redirect_if_not_logged_in

    @website = Website.find_by_id(params[:id])
    @tags = current_user.tags
    erb :'websites/edit'
  end

  patch '/websites/:id' do
    redirect_if_not_logged_in

    @website = Website.find_by_id(params[:id])

    if params[:content] != "" && @website.update(content: params[:content]) && @website.tag.update(content:params[:dropdown_tag])
      redirect to "/websites"
    else
      redirect to "/websites/#{@website.id}/edit"
    end
  end

  delete '/websites/:id/delete' do
    redirect_if_not_logged_in

    @website = Website.find_by_id(params[:id])
    @website.delete
    redirect to '/websites'
  end
end
