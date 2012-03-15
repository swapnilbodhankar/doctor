class HomeController < ApplicationController
  
   def index
     @users = User.all
     @patients = Patient.all
     @docters = Docter.all
     @hospitals = Hospital.all
   end

  def new
    respond_to do |format|
    if current_user.role? :doctor
      d = current_user.docters
        if d.empty?
          format.html { redirect_to new_docter_path }
        else
          format.html { redirect_to docters_path }
        end
    elsif current_user.role? :patient
      p = current_user.patients
        if p.empty?
          format.html { redirect_to new_patient_path }
        else
          format.html { redirect_to patients_path }
        end
    else current_user.role? :hospital
      h =current_user.hospitals
        if h.empty?
          format.html { redirect_to new_hospital_path }
        else
         format.html { redirect_to hospitals_path }
        end
      end
    end
  end
  
  def show
    
  end

end