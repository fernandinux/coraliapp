class ChangeColumnMinimumScoreOnEvents < ActiveRecord::Migration[6.0]
  def change
    change_table :events do |t|
      t.change :minimum_score, :integer
    end
  end
end
