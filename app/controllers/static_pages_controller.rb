class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @micropost  = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def help
    # empty
  end

  def about
    # empty
  end

  def contact
    # empty
  end
end
