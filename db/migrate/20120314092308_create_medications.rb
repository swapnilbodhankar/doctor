class CreateMedications < ActiveRecord::Migration
  def change
    create_table :medications do |t|
      t.string :medication
      t.string :take_medi
      t.date :started
      t.date :ended
      t.string :route
      t.string :strength
      t.string :how_many
      t.string :how_often
      t.text :journal_entry
      t.integer :user_id

      t.timestamps
    end
  end
end
