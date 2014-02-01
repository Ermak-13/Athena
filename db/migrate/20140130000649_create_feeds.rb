class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :url, limit: 2000
      t.text :description
      t.string :language
      t.datetime :last_modified_at

      t.timestamps
    end
  end
end
