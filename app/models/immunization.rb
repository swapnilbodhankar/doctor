class Immunization < ActiveRecord::Base
   belongs_to   :patient
     attr_accessible  :patient_id,:patient_ids, :immu_name, :date, :journal_entry, :user_id
end
