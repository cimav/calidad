class ChangeNameToRevisionField < ActiveRecord::Migration[5.1]
  def change
    rename_column :documents, :revision, :revision_number
  end
end
