class CreatePatients < ActiveRecord::Migration
  def change
    create_table   :patients do |t|
      t.string     :name
      t.integer    :phone
      t.string     :address_line1
      t.string     :address_line2
      t.string     :address_line3
      t.string     :suffering_from
      
      t.timestamps
    end
  end
end
