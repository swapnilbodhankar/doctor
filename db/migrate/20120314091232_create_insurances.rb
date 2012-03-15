class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.string :type_insurance
      t.string :comp_name
      t.string :plan_name
      t.string :plan_id
      t.string :group_no
      t.string :card_name
      t.string :policy_id
      t.string :insure_phone
      t.date :start_date
      t.date :end_date
      t.text :journal_entry
      t.integer :user_id

      t.timestamps
    end
  end
end
