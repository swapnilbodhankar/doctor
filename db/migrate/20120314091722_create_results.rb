class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :test_name
      t.string :final_result
      t.string :unit
      t.date :date_test
      t.string :goal
      t.string :per_entry
      t.string :journal_entry
      t.integer :user_id

      t.timestamps
    end
  end
end
