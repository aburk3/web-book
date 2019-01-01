class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :user_id
      t.integer :website_id

      t.timestamps null: false
    end
  end
end
