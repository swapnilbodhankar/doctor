class PatientsController < ApplicationController
  
  def new
    @patient = Patient.new
    allergy = @patient.allergies
    immunization = @patient.immunizations
    insurance = @patient.insurances
    problem = @patient.problems
    procedure = @patient.procedures
    result = @patient.results
    medication = @patient.medications

  end

  def index
      @patients = Patient.find_by_user_id(params[:id])
  end

  def show
      @patient = Patient.find_by_user_id(params[:id])
  end
  
  def edit
      @patient = Patient.find_by_user_id(params[:id])
  end
  
  def update
      @patient = Patient.find(params[:id])
      respond_to do |format|
      if @patient.update_attributes(params[:patient])
        format.html { redirect_to patients_path, notice: 'Patient was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end
  
 def create
     @patient = Patient.new(params[:patient])
     respond_to do |format|
      if @patient.save
        flash[:notice] = 'Patient was successfully created.'
        format.html { redirect_to patients_path }
        format.xml  { render :xml => @patient, :status => :created, :location => @patient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end
end
