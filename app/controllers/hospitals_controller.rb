class HospitalsController < ApplicationController
    

  def new
    @hospital = Hospital.new
  end

  def index
    @hospitals = Hospital.find_by_user_id(params[:id])
     @enquiries = Enquiry.find_by_id(params[:id])
  end

  def show
    @hospital = Hospital.find_by_user_id(params[:id])
     @enquiry = Enquiry.new
  end

  def edit
    @hospital = Hospital.find_by_user_id(params[:id])
  end
  
  def update
     @hospital = Hospital.find(params[:id])
      respond_to do |format|
      if @hospital.update_attributes(params[:hospital])
        format.html { redirect_to hospitals_path, notice: 'Hospital was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @hospital.errors, status: :unprocessable_entity }
      end
    end
  end
  
 def create
    @hospital = Hospital.new(params[:hospital])
    respond_to do |format|
      if @hospital.save
        flash[:notice] = 'Hospital was successfully created.'
        format.html { redirect_to hospitals_path }
        format.xml  { render :xml => @docter, :status => :created, :location => @hospital }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hospital.errors, :status => :unprocessable_entity }
      end
    end
  end

  
  
end
