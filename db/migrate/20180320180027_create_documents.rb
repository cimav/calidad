class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :code
      t.string :revision
      t.date :revision_date
      t.integer :document_type
      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
