class AddIdToImmunizations < ActiveRecord::Migration
  def change
    add_column :immunizations, :patient_id, :integer
  end
end
