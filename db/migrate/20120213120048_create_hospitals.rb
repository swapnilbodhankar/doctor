class CreateHospitals < ActiveRecord::Migration
  def change
    create_table   :hospitals do |t|
      t.string     :name
      t.string     :address_line1
      t.string     :address_line2
      t.string     :address_line3
      t.string     :emergency_service
      t.integer    :ambulance_contact
      t.string     :pharmacy_details
      t.integer    :no_of_private_room
      t.integer    :no_of_wards
      t.string     :specialities
      t.string     :doctor_list

      t.timestamps
    end
  end
end
