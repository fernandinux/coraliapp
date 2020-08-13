class ChangeNameAColumnToUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.rename :credential_count, :credentials_count
    end
  end
end
