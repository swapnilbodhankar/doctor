class AddIdToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :patient_id, :integer
  end
end
