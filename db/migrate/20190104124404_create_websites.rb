class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.text :content
      t.integer :user_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
