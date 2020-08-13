class AddCountColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :credential_count, :integer
  end
end
