class AddIdToProcedures < ActiveRecord::Migration
  def change
    add_column :procedures, :patient_id, :integer
  end
end
