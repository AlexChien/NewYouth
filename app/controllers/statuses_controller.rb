class StatusesController < ApplicationController

  before_filter :login_required

  # GET /statuses
  # GET /statuses.xml
  def index
    @type = params[:type] || 'raw'
      if @type == 'raw'
        condition = ["domain = ? and state is null", "thevoice"]
      elsif @type == 'auditing'
        condition = ["domain = ? and state = ?", "thevoice", 'auditing']
      elsif @type == 'sent'
        condition = ["domain = ? and state = ?", "thevoice", 'sent']
      else
        condition = ["domain = ?","thevoice"]
      end

    @statuses = Status.find(:all, :conditions => condition, :order => 'id DESC').paginate(:page => params[:page], :per_page => 20)
    @bulletin = Bulletin.new
    @bulletins = Bulletin.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statuses }
    end
  end

  def refresh
    Status.get_status
    @statuses = Status.paginate(:page => params[:page], :per_page => 20, :order => 'id DESC')
    @bulletin = Bulletin.new
    @bulletins = Bulletin.all
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
    Feed.create(
      :user => @status.screen_name,
      :content => @status.text
    )
    respond_to do |format|
      if @status.save
        # format.html { redirect_to(@status, :notice => 'Status was successfully updated.') }
        format.html { redirect_to('/?type=auditing', :notice => "消息 #{@status.text} 已成功发送至播放池，等待播放.") }
        format.xml  { head :ok }
      else
        # format.html { render :action => "edit" }
        format.html { redirect_to('/', :error => "消息 #{@status.text} 无法投入播放池.") }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  def submit
    @status = Status.find(params[:id])
    @status.state = 'auditing'

    respond_to do |format|
      if @status.save
        format.html { redirect_to('/', :notice => "消息 #{@status.text} 已成功送审.") }
        format.xml  { head :ok }
      else
        # format.html { render :action => "edit" }
        format.html { redirect_to('/', :error => "消息 #{@status.text} 送审失败。") }
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
