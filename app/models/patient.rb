class Patient < ActiveRecord::Base
    belongs_to                :user
    has_many                  :allergies
    has_many                  :immunizations
    has_many                  :problems
    has_many                  :insurances
    has_many                  :medications
    has_many                  :procedures
    has_many                  :results
    attr_accessible           :name, :phone, :address_line1, :address_line2, :address_line3, 
                              :suffering_from, :patient_ids,:patient_id,  :user_id, 
                              :allergies_attributes, :immunizations_attributes, :insurances_attributes, 
                              :problems_attributes, :procedures_attributes, :results_attributes,:medications_attributes
                              
    accepts_nested_attributes_for :allergies, :immunizations, :insurances, :problems, :procedures,:results,:medications
end
