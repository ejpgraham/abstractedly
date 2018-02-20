class CreateCustomKeywords < ActiveRecord::Migration[5.1]
  def change
    create_table :custom_keywords do |t|

      t.timestamps
    end
  end
end
