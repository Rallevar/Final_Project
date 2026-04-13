class CreateAboutPages < ActiveRecord::Migration[7.2]
  def change
    create_table :about_pages do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end