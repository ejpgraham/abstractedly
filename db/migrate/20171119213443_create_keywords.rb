class CreateKeywords < ActiveRecord::Migration[5.0]
  def change
    create_table :keywords do |t|
      t.string :body
      t.references :abstract, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
