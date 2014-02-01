class Feed < ActiveRecord::Base
  has_many :News

  validates :url, url: true, uniqueness: {case_sensitive: false}
  validate :validate_feed_url

  def fetch_attributes!
    feed = Feedzirra::Feed.fetch_and_parse(self.url)

    self.update(
      title: feed.title,
      description: feed.description,
    )
  end

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

  private
    def validate_feed_url
      feed = Feedzirra::Feed.fetch_and_parse(self.url)
      if feed.is_a? Fixnum
        errors.add(:url, 'Feed url is not valid.')
      end
    end
end
