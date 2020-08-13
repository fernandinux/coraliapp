class CreateScoreUser < ActiveRecord::Migration[6.0]
  def change
    create_table :score_users do |t|
      t.decimal :score
      t.integer :user_id
      t.integer :event_id
    end
  end
end
