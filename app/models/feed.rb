class Feed < ActiveRecord::Base
  has_many :News

  validates :title, presence: true
  validates :url, url: true

  def fetch_and_parse!
    feed = Feedzirra::Feed.fetch_and_parse(self.url)

    if self.last_modified_at.blank?  || self.last_modified_at < feed.last_modified
      last_news = News.where(feed_id: self.id).last
      feed.entries.each do |entry|
        if last_news.blank? || last_news.publicated_at < entry.published
          News.parse_entry(entry)
        end
      end

      self.update(
        last_modified_at: feed.last_modified
      )
    end
  end
end
