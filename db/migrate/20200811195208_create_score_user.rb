class CreateScoreUser < ActiveRecord::Migration[6.0]
  def change
    create_table :score_users do |t|
      t.decimal :score
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.timestamps
    end
  end
end
