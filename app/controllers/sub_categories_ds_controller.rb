class SubCategoriesDsController < ApplicationController
  # GET /sub_categories_ds
  # GET /sub_categories_ds.json
  def index
    @sub_categories_ds = SubCategoriesD.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sub_categories_ds }
    end
  end

  # GET /sub_categories_ds/1
  # GET /sub_categories_ds/1.json
  def show
    @sub_categories_d = SubCategoriesD.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sub_categories_d }
    end
  end

  # GET /sub_categories_ds/new
  # GET /sub_categories_ds/new.json
  def new
    @sub_categories_d = SubCategoriesD.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sub_categories_d }
    end
  end

  # GET /sub_categories_ds/1/edit
  def edit
    @sub_categories_d = SubCategoriesD.find(params[:id])
  end

  # POST /sub_categories_ds
  # POST /sub_categories_ds.json
  def create
    @sub_categories_d = SubCategoriesD.new(params[:sub_categories_d])

    respond_to do |format|
      if @sub_categories_d.save
        format.html { redirect_to @sub_categories_d, notice: 'Sub categories d was successfully created.' }
        format.json { render json: @sub_categories_d, status: :created, location: @sub_categories_d }
      else
        format.html { render action: "new" }
        format.json { render json: @sub_categories_d.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sub_categories_ds/1
  # PUT /sub_categories_ds/1.json
  def update
    @sub_categories_d = SubCategoriesD.find(params[:id])

    respond_to do |format|
      if @sub_categories_d.update_attributes(params[:sub_categories_d])
        format.html { redirect_to @sub_categories_d, notice: 'Sub categories d was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @sub_categories_d.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_categories_ds/1
  # DELETE /sub_categories_ds/1.json
  def destroy
    @sub_categories_d = SubCategoriesD.find(params[:id])
    @sub_categories_d.destroy

    respond_to do |format|
      format.html { redirect_to sub_categories_ds_url }
      format.json { head :ok }
    end
  end
 
 
end
