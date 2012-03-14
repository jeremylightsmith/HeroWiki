class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :page
      t.has_attached_file :content
      t.timestamps
    end
  end
end
