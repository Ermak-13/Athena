class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :worker_type
      t.text :info
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
