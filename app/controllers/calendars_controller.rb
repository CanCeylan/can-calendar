class CalendarsController < ApplicationController
  # GET /calendars
  # GET /calendars.json
  def index
    @calendars = Calendar.all

    @events = @calendars.each_with_object([]) {|cal, array| array << cal.jsonize }.to_json
    @resources = Resource.all.each_with_object([]) {|res, array| array << res.jsonize }.to_json


    respond_to do |format|
      format.html
      format.json { render json: @calendars }
    end
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
    @calendar = Calendar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calendar }
    end
  end

  # GET /calendars/new
  # GET /calendars/new.json
  def new
    @calendar = Calendar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calendar }
    end
  end

  # GET /calendars/1/edit
  def edit
    @calendar = Calendar.find(params[:id])
  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = Calendar.new(params[:calendar])

    respond_to do |format|
      if @calendar.save
        format.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }
        format.json { render json: @calendar.jsonize, status: :created, location: @calendar}
      else
        format.html { render action: "new" }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calendars/1
  # PUT /calendars/1.json
  def update
    @calendar = Calendar.find(params[:id])

    respond_to do |format|
      if @calendar.update_attributes(params[:calendar])
        format.html { redirect_to @calendar, notice: 'Calendar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar = Calendar.find(params[:id])
    @calendar.destroy

    respond_to do |format|
      format.html { redirect_to calendars_url }
      format.json { head :no_content }
    end
  end

  def eventDrop

    @id = params[:id]
    @interval = params[:dayDelta]

    @cal = Calendar.find(@id)

    @cal.update_attributes(:start)
    n = 1

    @uids.each do |id|
      upload = Upload.find(id)
      upload.update_attribute(:position, n)
      n += 1
    end

  end


end
