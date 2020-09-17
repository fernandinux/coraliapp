class CreateDesigns < ActiveRecord::Migration[6.0]
  def change
    create_table :designs do |t|
      t.string :editor_id
      t.string :url
      t.references :user, null: false, foreign_key: true
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
