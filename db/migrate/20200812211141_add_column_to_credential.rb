class AddColumnToCredential < ActiveRecord::Migration[6.0]
  def change
    add_column :credentials, :created_at, :datetime, null: false
    add_column :credentials, :updated_at, :datetime, null: false
  end
end
