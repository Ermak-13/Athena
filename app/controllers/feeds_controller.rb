class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
  end

  def create
    feed_url = params[:feed][:url]
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)

    if feed.present?
      Feed.create(
        url: feed_url,
        title: feed.title || params.permit(:title),
        description: feed.description || params.permit(:description),
      )

      redirect_to :index
    else
      flash[:alert] = 'Feed url is not valid.'
      redirect_to
    end
  end
end
