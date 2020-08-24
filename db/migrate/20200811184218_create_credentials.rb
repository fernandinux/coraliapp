class CreateCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :credentials do |t|
      t.string :title
      t.string :body
      t.string :code
      t.integer :type_credential, default: 0
      t.integer :status, default: 0
      t.string :dni_user
      t.string :email_user
      t.date :expiration_at
      t.references :user, null: true, foreign_key: true
      t.references :event, null: true, foreign_key: true
      t.timestamps
    end
  end
end
