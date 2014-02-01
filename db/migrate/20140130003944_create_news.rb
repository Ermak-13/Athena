class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.integer :feed_id

      t.string :title
      t.string :url, limit: 2000
      t.text :description
      t.datetime :publicated_at
      t.string :author

      t.timestamps
    end
  end
end
