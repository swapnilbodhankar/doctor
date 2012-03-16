class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :symptom
      t.string :problem
      t.date :started
      t.date :ended
      t.text :journal_entry
      t.integer :user_id

      t.timestamps
    end
  end
end
