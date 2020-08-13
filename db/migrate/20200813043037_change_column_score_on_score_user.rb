class ChangeColumnScoreOnScoreUser < ActiveRecord::Migration[6.0]
  def change 
    change_table :score_users do |t|
      t.change :score, :integer
    end
  end
end
