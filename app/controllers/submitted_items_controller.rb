class SubmittedItemsController < ApplicationController
  #before_filter check_administrator_role, :except => [:index, :show]
  before_filter :require_user
  
  def index
    @submitteditems = SubmittedItem.find(:all)
  end

  def new
    @item = SubmittedItem.new
  end

  def create
    @item = SubmittedItem.new(params[:submitted_item])
    
    @item.user = current_user
    #@submitted.published? = false
    
    if @item.save
      flash[:notice] = "funciono"
      redirect_to :action => :new
    else
      redirect_to :action => :new
    end
      
  end

end
