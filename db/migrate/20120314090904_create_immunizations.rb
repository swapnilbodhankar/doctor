class CreateImmunizations < ActiveRecord::Migration
  def change
    create_table :immunizations do |t|
      t.string :immu_name
      t.date :date
      t.text :journal_entry
      t.integer :user_id

      t.timestamps
    end
  end
end
