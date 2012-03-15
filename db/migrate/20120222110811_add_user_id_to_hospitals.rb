class AddUserIdToHospitals < ActiveRecord::Migration
  def change
    add_column :hospitals, :user_id, :integer
  end
end
