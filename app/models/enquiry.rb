class Enquiry < ActiveRecord::Base
  belongs_to :docter
  belongs_to :hospitals
  
  attr_accessible  :name,:email,:phone_no,:message,:docter_ids, :docter_id, :user_email
  
  
end
