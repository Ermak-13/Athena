class News < ActiveRecord::Base
  belongs_to :feed

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
