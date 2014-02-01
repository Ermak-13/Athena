class Task < ActiveRecord::Base
  def self.build(worker)
    task = Task.create(
      worker_type: worker.name,
      started_at: Time.current
    )
    Resque.enqueue(worker, task.id)
  end

  def self.aggregate_feeds
    self.build(AggregatorFeeds)
  end
end
