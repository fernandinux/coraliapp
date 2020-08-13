class ChangeNameToEvent < ActiveRecord::Migration[6.0]
  def change
    change_table :events do |t|
      t.rename :organization_count, :organizations_count
    end
  end
end
