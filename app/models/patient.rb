class Patient < ActiveRecord::Base
    belongs_to                :user
    has_many                  :allergies
    has_many                  :immunizations
    has_many                  :problems
    has_many                  :insurances
    has_many                  :medications
    has_many                  :procedures
    has_many                  :results
    attr_accessible :user_id, :name, :phone, :address_line1, :address_line2, :address_line3, :suffering_from, :patient_id
    accepts_nested_attributes_for :allergies
end
