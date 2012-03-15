class Docter < ActiveRecord::Base
  
  has_and_belongs_to_many   :categories_ds
  belongs_to                :user
  has_many                  :enquiries
  
  attr_accessible           :categories_d_ids, :name, :address_line1, :address_line2, :address_line3, 
                            :state, :city, :country, :contact_no, :fax_no, :website_url, :qualification, 
                            :speciality, :affiliation, :awards, :user_id

end
