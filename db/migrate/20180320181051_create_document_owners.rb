class CreateDocumentOwners < ActiveRecord::Migration[5.1]
  def change
    create_table :document_owners do |t|
      t.references :document, foreign_key: true
      t.string :owner_name
      t.string :owner_email

      t.timestamps
    end
  end
end
