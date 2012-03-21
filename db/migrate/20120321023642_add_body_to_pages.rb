class AddBodyToPages < ActiveRecord::Migration
  def up
    add_column :pages, :body, :text
    remove_column :pages, :body_html
    add_column :versions, :description, :string

    Page.all.each do |page|
      page.body = page.versions.last.body if page.versions.last
      page.save!
    end
  end

  def down
    remove_column :pages, :body
    add_column :pages, :body_html, :text
    remove_column :versions, :description
  end
end
