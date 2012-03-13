class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :provider
      t.string :uid
      t.boolean :editor
      t.boolean :admin

      t.timestamps
    end
  end
end
