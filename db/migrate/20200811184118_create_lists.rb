class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :name
      t.string :status
      t.integer :add_linkedin_count
      t.integer :list_visits_count
      t.integer :web_views_count
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
