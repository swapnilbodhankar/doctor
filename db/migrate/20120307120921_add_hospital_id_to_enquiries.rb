class AddHospitalIdToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :hospital_id, :integer
  end
end
