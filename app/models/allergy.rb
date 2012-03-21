class Allergy < ActiveRecord::Base
     belongs_to       :patient

     attr_accessible  :patient_id,:patient_ids,  :allergic, :affect, :started, :ended, :severity, :journal_entry, :user_id
     
end
