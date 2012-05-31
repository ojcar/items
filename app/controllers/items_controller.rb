class ItemsController < ApplicationController
  before_filter :check_administrator_role, :except => [:index, :show]
  before_filter :require_user, :except => [:index, :show]
  autocomplete :category, :name, :full => true
  autocomplete :author, :name, :full => true
  autocomplete :source, :name, :full => true
  
  # GET /items
  # GET /items.xml
  def index
    @items = Item.find(:all, :limit => 30)
    @featured = Item.find(:all, :limit => 3)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])
    @featured = Item.find(:all, :limit=> 5)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])
      
    @item.category = Category.find_or_create_by_name(:name => params[:category][:name])
    @item.author = Author.find_or_create_by_name(params[:author][:name])
    @item.source = Source.find_or_create_by_name(:name => params[:source][:name])
    #@item.source = Source.find_or_create_by_name(:name => params[:source][:name], :url => get_domain_from_url(params[:item][:url]))
    @item.user = current_user
    
    @item_cache = ItemCache.new(:content => params[:item_cache][:content])
    

    respond_to do |format|
      if @item.save
        @item_cache.item_id = @item.id
        @item_cache.save
        format.html { redirect_to(@item, :notice => 'Item was successfully created.') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to(@item, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
  
  
  #private
  def get_domain_from_url(url)
    require 'uri'
    url = "http://#{url}" unless url.start_with?('http')
    host = URI.parse(url).host
    
    "http://#{host}"
  end
  
  
end
