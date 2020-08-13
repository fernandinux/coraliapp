class ChangeNameColumnsToCredential < ActiveRecord::Migration[6.0]
  def change
    change_table :credentials do |t|
      t.rename :type, :credential_type
    end
  end
end
