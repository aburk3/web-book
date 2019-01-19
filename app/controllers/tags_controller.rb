class TagsController < ApplicationController

  get '/tags/:id' do
    redirect_if_not_logged_in

    @tags = current_user.tags
    @tag = Tag.find_by_id(params[:id])
    @websites = []
    @tag.websites.each do |website|
      if website.user == current_user
        @websites << website
      end
    end
    erb :'tags/show'
  end
end
