class CreateAbstracts < ActiveRecord::Migration
  def change
    create_table :abstracts do |t|
      t.text :title
      t.text :authors
      t.text :body
      t.string :images
      t.string :url
      t.boolean :visible

      t.references :journal, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
