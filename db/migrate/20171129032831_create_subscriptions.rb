class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :journal_feed, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
