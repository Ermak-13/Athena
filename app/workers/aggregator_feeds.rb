class AggregatorFeeds
  @queue = :aggregator_feeds

  def self.perform(task_id)
    task = Task.find(task_id)

    task_info = {}
    Feed.all.each do |feed|
      feed.fetch_and_parse!
    end

    task.update(
      finished_at: Time.current,
      info: task_info.to_json
    )

    task
  end
end
