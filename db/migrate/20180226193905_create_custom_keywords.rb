class CreateCustomKeywords < ActiveRecord::Migration[5.1]
  def change
    create_table :custom_keywords do |t|
      t.string :body
      t.references :user, index: true, foreign_key: true
      t.references :abstract, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
