class News < ActiveRecord::Base
  belongs_to :feed

  validates :title, presence: true
  validates :url, url: true
  validates :publicated_at, presence: true

  def self.parse_entry(entry)
    News.create(
      title: entry.title,
      url: entry.url,
      description: entry.content,
      publicated_at: entry.published,
      author: entry.author
    )
  end
end
