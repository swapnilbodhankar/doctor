class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
      @a = current_user.id
      @b = User.where(:s_id => @a)
       # @users = User.find(params[:id])
      respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
      end
  end
  
end
