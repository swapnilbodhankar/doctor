class CountriesController < ApplicationController
   before_filter :find_country, :except => [:index, :new, :create]
def index
@countries = Country.all
end

def new
@country = Country.new
end

def edit
end

def create
@country = Country.new(params[:country])
if @country.save
redirect_to countries_path
else
render :action => :new
end
end

def update
if @country.update_attributes(params[:country])
redirect_to countries_path
else
render :action => :edit
end
end

private
def find_country
@country = Country.find(params[:id])
end
end
