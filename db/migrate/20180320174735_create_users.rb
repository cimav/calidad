class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.integer :status
      t.integer :user_type

      t.timestamps
    end
  end
end
