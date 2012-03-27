class DoctersController < ApplicationController

  def new
    @docter = Docter.new
  end
  
  def create
    @docter = Docter.new(params[:docter])
    respond_to do |format|
      if @docter.save
        flash[:notice] = 'Doctor was successfully created.'
        format.html { redirect_to docters_path}
        format.xml  { render :xml => @docter, :status => :created, :location => @docter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @docter.errors, :status => :unprocessable_entity }
      end
    end
  end
  def index
        @docters = Docter.new
    @docters = Docter.find_by_user_id(params[:id])
  
    @enquiries = Enquiry.find_by_id(params[:id])

  end

  def show
    @docter = Docter.find_by_id(params[:id])
    @enquiry = Enquiry.new
  end

  def edit
     @docter = Docter.find_by_user_id(params[:id])
  end
  def update
     @docter = Docter.find(params[:id])
      respond_to do |format|
      if @docter.update_attributes(params[:docter])
        format.html { redirect_to docters_path, notice: 'Doctor was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @docter.errors, status: :unprocessable_entity }
      end
    end
  end
 
end
