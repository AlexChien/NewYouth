class BulltinsController < ApplicationController
  
  before_filter :login_required, :except => [:index]
  
  # GET /bulltins
  # GET /bulltins.xml
  def index
    @bulltins = Bulltin.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml # { render :xml => @bulltins }
    end
  end

  # GET /bulltins/1
  # GET /bulltins/1.xml
  def show
    @bulltin = Bulltin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bulltin }
    end
  end

  # GET /bulltins/new
  # GET /bulltins/new.xml
  def new
    @bulltin = Bulltin.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bulltin }
    end
  end

  # GET /bulltins/1/edit
  def edit
    @bulltin = Bulltin.find(params[:id])
  end

  # POST /bulltins
  # POST /bulltins.xml
  def create
    @bulltin = Bulltin.new(params[:bulltin])

    respond_to do |format|
      if @bulltin.save
        flash[:notice] = 'Bulltin was successfully created.'
        # format.html { redirect_to(@bulltin) }
        format.html { redirect_to '/' }
        format.xml  { render :xml => @bulltin, :status => :created, :location => @bulltin }
      else
        # format.html { render :action => "new" }
        format.html { redirect_to '/' }
        format.xml  { render :xml => @bulltin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bulltins/1
  # PUT /bulltins/1.xml
  def update
    @bulltin = Bulltin.find(params[:id])

    respond_to do |format|
      if @bulltin.update_attributes(params[:bulltin])
        flash[:notice] = 'Bulltin was successfully updated.'
        format.html { redirect_to(@bulltin) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bulltin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bulltins/1
  # DELETE /bulltins/1.xml
  def destroy
    @bulltin = Bulltin.find(params[:id])
    @bulltin.destroy

    respond_to do |format|
      format.html { redirect_to(bulltins_url) }
      format.xml  { head :ok }
    end
  end
end
