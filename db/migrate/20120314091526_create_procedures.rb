class CreateProcedures < ActiveRecord::Migration
  def change
    create_table :procedures do |t|
      t.string :surgery
      t.date :started
      t.date :ended
      t.text :journal_entry
      t.integer :user_id

      t.timestamps
    end
  end
end
