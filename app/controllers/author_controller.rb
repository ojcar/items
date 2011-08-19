class AuthorController < ApplicationController
  def index
	@authors = Author.all
	
	respond_to do |format|
		format.html
		format.xml { render :xml => @authors }
	end
  end

  def show
	@author = Author.find(params[:id])
	
	respond_to do |format|
		format.html
		format.xml { render :xml => @author }
	end
  end

  def new
	@author = Author.new
  end
  
  def create
	@author = Author.new(params[:author])
	
	respond_to do |format|
		if @author.save
			format.html { redirect_to(@author, :notice => 'El autor ha sido agregado') }
			format.xml { render :xml => @author, :status => :created, :location => @author }
		else
			format.html { render :action => "new" }
			format.xml { render :xml => @author.errors, :status => :unprocessable_entity }
		end
	end
  end
  
  def edit
	@author = Author.find(params[:id])
  end

  def update
  end

  def destroy
  end

end
