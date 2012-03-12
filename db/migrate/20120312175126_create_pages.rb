class CreatePages < ActiveRecord::Migration
  def change
    create_table "pages", :force => true do |t|
      t.string    "name"
      t.string    "url"
      t.text      "body_html"
      t.string    "page_class"

      t.timestamp "deleted_at"
      t.timestamps
    end
  end
end
