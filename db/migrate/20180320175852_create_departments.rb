class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :manager_name
      t.string :manager_email

      t.timestamps
    end
  end
end
