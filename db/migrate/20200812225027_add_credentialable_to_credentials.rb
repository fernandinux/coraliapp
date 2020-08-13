class AddCredentialableToCredentials < ActiveRecord::Migration[6.0]
  def change
    add_reference :credentials, :credentialable, polymorphic: true
  end
end
