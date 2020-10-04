class CreateEstadisticas < ActiveRecord::Migration[6.0]
  def change
    create_table :estadisticas do |t|
      t.integer :user_id
      t.integer :add_linkedin_count
      t.integer :list_visits_count
      t.integer :web_views_count
      t.integer :share_linkedin
      t.string :list_name

      t.timestamps
    end
  end
end
