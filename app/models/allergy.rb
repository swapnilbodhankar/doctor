class Allergy < ActiveRecord::Base
     belongs_to       :patient
     attr_accessible  :patient_id
end
