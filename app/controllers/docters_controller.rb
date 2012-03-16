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
     @countries  = Country.find(:all)
    @states = State.find(:all)
    @cities   = City.find(:all)
  end

  def show
    @docter = Docter.find_by_user_id(params[:id])
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
   def update_states
    # updates artists and songs based on genre selected
     country = Country.find(params[:country_id])
    states = country.states
    cities   = country.cities

    render :update do |page|
      page.replace_html 'states',  :partial => 'states', :object => states
      page.replace_html 'cities',   :partial => 'cities',   :object => cities
    end
  end

  def update_cities
    # updates songs based on artist selected
    state = State.find(params[:state_id])
    cities  = state.cities

    render :update do |page|
      page.replace_html 'cities', :partial => 'cities', :object => cities
    end
  end
end
