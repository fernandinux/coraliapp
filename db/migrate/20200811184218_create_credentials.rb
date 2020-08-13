class CreateCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :credentials do |t|
      t.string :body
      t.integer :credential_id
      t.string :type
      t.string :status
      t.integer :dni_user
      t.date :created_at
      t.date :expiration_at
    end
  end
end
