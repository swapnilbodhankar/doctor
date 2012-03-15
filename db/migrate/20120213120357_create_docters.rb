class CreateDocters < ActiveRecord::Migration
  def change
    create_table   :docters do |t|
      t.string     :name
      t.string     :address_line1
      t.string     :address_line2
      t.string     :address_line3
      t.string     :state
      t.string     :city
      t.string     :country
      t.integer    :contact_no
      t.integer    :fax_no
      t.string     :website_url
      t.string     :qualification
      t.string     :speciality
      t.string     :affiliation
      t.string     :awards
      
      
      t.timestamps
    end
  end
end
