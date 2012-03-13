# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120313085952) do

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "body_html"
    t.string   "page_class"
    t.datetime "deleted_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
  end

  create_table "pages_tags", :id => false, :force => true do |t|
    t.integer "page_id"
    t.integer "tag_id"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "editor"
    t.boolean  "admin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "versions", :force => true do |t|
    t.integer  "version"
    t.integer  "versionable_id"
    t.string   "versionable_type"
    t.integer  "author_id"
    t.text     "body"
    t.boolean  "deletion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
