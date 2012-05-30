class RolesController < ApplicationController
  before_filter :check_administrator_role
  
  def index
    @roles = Role.all
  end
  
  def show
    @role = Role.find(params[:id])
  end
  
  def new
    @role = Role.new
  end
  
  def create
    @role = Role.new(params[:role])
    
    if @role.save
      redirect_to(@role, :notice => 'Success')
    else
      render :action => 'new'
    end
  end
end
