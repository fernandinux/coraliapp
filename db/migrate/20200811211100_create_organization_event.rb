class CreateOrganizationEvent < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_events do |t|
      t.integer :event_id
      t.integer :organization_id
    end
  end
end
