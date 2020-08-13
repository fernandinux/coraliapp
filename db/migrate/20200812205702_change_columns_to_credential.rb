class ChangeColumnsToCredential < ActiveRecord::Migration[6.0]
  def change
    change_table :credentials do |t|
      t.remove :created_at
    end
  end
end
