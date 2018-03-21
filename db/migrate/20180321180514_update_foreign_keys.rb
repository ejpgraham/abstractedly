class UpdateForeignKeys < ActiveRecord::Migration[5.1]
  def change
    # foreign key needs cascade to allow descruction of journals and their children
    # abstracts and keywords

    remove_foreign_key :custom_keywords, :abstracts
    remove_foreign_key :keywords, :abstracts
    remove_foreign_key :abstracts, :journals

    add_foreign_key :custom_keywords, :abstracts, on_delete: :cascade
    add_foreign_key :keywords, :abstracts, on_delete: :cascade
    add_foreign_key :abstracts, :journals, on_delete: :cascade


  end
end
