class CreateAllergies < ActiveRecord::Migration
  def change
    create_table :allergies do |t|
      t.string :allergic
      t.string :affect
      t.date :started
      t.date :ended
      t.string :severity
      t.text :journal_entry
      t.integer :user_id

      t.timestamps
    end
  end
end
