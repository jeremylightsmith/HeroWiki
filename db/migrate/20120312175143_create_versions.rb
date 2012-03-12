class CreateVersions < ActiveRecord::Migration
  def change
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
end
