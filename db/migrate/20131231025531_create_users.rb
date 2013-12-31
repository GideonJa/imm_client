class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :person_id
      t.string :state

      t.timestamps
    end
    add_index :users, :person_id,                :unique => true
  end
end
