# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180403004214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abstracts", force: :cascade do |t|
    t.text "title"
    t.text "authors"
    t.text "body"
    t.string "images"
    t.string "url"
    t.boolean "visible"
    t.integer "journal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["journal_id"], name: "index_abstracts_on_journal_id"
  end

  create_table "custom_keywords", force: :cascade do |t|
    t.string "body"
    t.bigint "user_id"
    t.bigint "abstract_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abstract_id"], name: "index_custom_keywords_on_abstract_id"
    t.index ["user_id"], name: "index_custom_keywords_on_user_id"
  end

  create_table "journal_feeds", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.string "cover_image_url"
  end

  create_table "journals", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.date "date"
    t.integer "volume"
    t.integer "issue_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "journal_feed_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.string "body"
    t.integer "abstract_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abstract_id"], name: "index_keywords_on_abstract_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "journal_feed_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["journal_feed_id"], name: "index_subscriptions_on_journal_feed_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "abstracts", "journals", on_delete: :cascade
  add_foreign_key "custom_keywords", "abstracts", on_delete: :cascade
  add_foreign_key "custom_keywords", "users"
  add_foreign_key "journals", "journal_feeds"
  add_foreign_key "keywords", "abstracts", on_delete: :cascade
end
