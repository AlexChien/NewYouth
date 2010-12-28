class StatusesController < ApplicationController
  
  before_filter :login_required
  
  # GET /statuses
  # GET /statuses.xml
  def index
    @statuses = Status.paginate(:page => params[:page], :per_page => 20, :order => 'id DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statuses }
    end
  end

  def refresh
    Status.get_status
    @statuses = Status.all(:order => "id desc")
    redirect_to '/'
  end


  # GET /statuses/1
  # GET /statuses/1.xml
  def show
    @status = Status.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @status }
    end
  end

  # GET /statuses/new
  # GET /statuses/new.xml
  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @status }
    end
  end

  # GET /statuses/1/edit
  def edit
    @status = Status.find(params[:id])
  end

  # POST /statuses
  # POST /statuses.xml
  def create
    @status = Status.new(params[:status])

    respond_to do |format|
      if @status.save
        format.html { redirect_to(@status, :notice => 'Status was successfully created.') }
        format.xml  { render :xml => @status, :status => :created, :location => @status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /statuses/1
  # PUT /statuses/1.xml
  def update
    @status = Status.find(params[:id])
    @status.state = 'sent'
    @status.save
    Feed.create(
      :user => @status.screen_name,
      :content => @status.text
    )
    respond_to do |format|
      if @status.update_attributes(params[:status])
        # format.html { redirect_to(@status, :notice => 'Status was successfully updated.') }
        format.html { redirect_to('/', :notice => "Status  #{@status.text} was successfully sent to screen.") }
        format.xml  { head :ok }
      else
        # format.html { render :action => "edit" }
        format.html { redirect_to('/', :error => "Status #{@status.text} sent to screen fail.") }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.xml
  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    respond_to do |format|
      format.html { redirect_to(statuses_url) }
      format.xml  { head :ok }
    end
  end
end
