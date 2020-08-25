class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.decimal :minimum_score
      t.date :date_programmed
      t.integer :organizations_count, default: 0
      t.timestamps
    end
  end
end
