class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
  end

  def create
    feed = Feed.create feed_params

    if feed.valid?
      feed.fetch_attributes!

      flash[:notice] = 'Feed was created!'
      redirect_to feeds_path
    else
      flash[:alert] = 'Feed url is not valid!'
      redirect_to feeds_path
    end
  end

  private
    def feed_params
      params.require(:feed).permit(:url)
    end
end
