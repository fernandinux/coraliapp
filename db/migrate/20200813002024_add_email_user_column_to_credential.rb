class AddEmailUserColumnToCredential < ActiveRecord::Migration[6.0]
  def change
    add_column :credentials, :email_user, :string
  end
end
