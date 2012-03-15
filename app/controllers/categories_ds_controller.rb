class CategoriesDsController < ApplicationController
  # GET /categories_ds
  # GET /categories_ds.json
  def index
    @categories_ds = CategoriesD.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories_ds }
    end
  end

  # GET /categories_ds/1
  # GET /categories_ds/1.json
  def show
    @categories_d = CategoriesD.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @categories_d }
    end
  end

  # GET /categories_ds/new
  # GET /categories_ds/new.json
  def new
    @categories_d = CategoriesD.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @categories_d }
    end
  end

  # GET /categories_ds/1/edit
  def edit
    @categories_d = CategoriesD.find(params[:id])
  end

  # POST /categories_ds
  # POST /categories_ds.json
  def create
    @categories_d = CategoriesD.new(params[:categories_d])

    respond_to do |format|
      if @categories_d.save
        format.html { redirect_to @categories_d, notice: 'Categories d was successfully created.' }
        format.json { render json: @categories_d, status: :created, location: @categories_d }
      else
        format.html { render action: "new" }
        format.json { render json: @categories_d.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories_ds/1
  # PUT /categories_ds/1.json
  def update
    @categories_d = CategoriesD.find(params[:id])

    respond_to do |format|
      if @categories_d.update_attributes(params[:categories_d])
        format.html { redirect_to @categories_d, notice: 'Categories d was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @categories_d.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories_ds/1
  # DELETE /categories_ds/1.json
  def destroy
    @categories_d = CategoriesD.find(params[:id])
    @categories_d.destroy

    respond_to do |format|
      format.html { redirect_to categories_ds_url }
      format.json { head :ok }
    end
  end
  def for_categories_d_id
     @sub_categories_d = SubCategoriesD.find( :all, :conditions => [" categories_d_id = ?", params[:id]]  ).sort_by{ |k| k['name'] }    
      respond_to do |format|
        format.json  { render :json => @sub_categories_d  }      
      end
     end
end
