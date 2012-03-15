class Medication < ActiveRecord::Base
   belongs_to   :patient
end
