class EnquiriesController < ApplicationController
  def new
    @docter = Docter.find_by_id(params[:id])
    @hospital = Hospital.find_by_id(params[:id])
    @enquiry = Enquiry.new
  end
 def create
    @enquiry = Enquiry.new(params[:enquiry])
    respond_to do |format|
      if @enquiry.save
        EnquiryMailer.enquiry_confirmation(@enquiry).deliver
        flash[:notice] = 'Enquiry was successfully created.'
        format.html { redirect_to   root_path}
        format.xml  { render :xml => @enquiry, :status => :created, :location => @enquiry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @enquiry.errors, :status => :unprocessable_entity }
      end
    end
  end


end
