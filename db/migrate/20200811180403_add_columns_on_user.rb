class AddColumnsOnUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last_name, :string
    add_column :users, :dni, :integer
  end
end
