class StaticPagesController < ApplicationController
  def home
    @feed_items = Micropost.all.paginate(page: params[:page])
    @micropost=current_user.microposts.build if logged_in?
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
