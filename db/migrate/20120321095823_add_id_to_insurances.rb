class AddIdToInsurances < ActiveRecord::Migration
  def change
    add_column :insurances, :patient_id, :integer
  end
end
