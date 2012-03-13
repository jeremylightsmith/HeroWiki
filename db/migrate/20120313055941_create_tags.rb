class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    create_table :pages_tags, id:false do |t|
      t.references :page
      t.references :tag
    end
  end
end
