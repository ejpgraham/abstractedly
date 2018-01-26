class CreateJournals < ActiveRecord::Migration[5.0]
  def change
    create_table :journals do |t|
      t.string :title
      t.string :url
      t.boolean :subscribed
      t.date :date
      t.integer :volume
      t.integer :issue_number
      t.timestamps null: false
    end
  end
end
