class RoomsController < ApplicationController
  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rooms }
    end
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @room = Room.find(params[:id])

    if params[:from] == 'click'
      start_date = params[:start_date].to_date
      @Jevents = @room.events.where(:start_date => (start_date.beginning_of_month - 5.days)..(start_date.end_of_month+9.days)).each_with_object([]) {|e, array| array << e.jsonize }.to_json
      respond_to do |format|
        format.js { render :layout => false}
      end
    else
      @Jevents = @room.events.where(:start_date => Time.now.beginning_of_month..Time.now.end_of_month).collect{|e| e.jsonize }.to_json
      respond_to do |format|
        format.html # show.html.erb
        format.js { render :layout => false}
      end
    end

  end

  # GET /rooms/new
  # GET /rooms/new.json
  def new
    @room = Room.new
    @room.events.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])

    if params[:eid] != nil
      @event = @room.events.find(params[:eid])
      respond_to do |format|
        format.js { render :layout => false}
      end
    elsif params[:from] == 'select'
      @event = @room.events.build(:start_date => params[:start_date], :end_date => params[:end_date])
      respond_to do |format|
        format.js { render :layout => false}
      end
    else
      @event = @room.events
      respond_to do |format|
        format.js { render :layout => false }
      end
    end
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(params[:room])

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render json: @room, status: :created, location: @room }
      else
        format.html { render action: "new" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    @room = Room.find(params[:id])
    @eType = params[:commit]

    respond_to do |format|
      if @room.update_attributes(params[:room])
        @Jevents = @room.reload.events.reload.all.each_with_object([]) {|e, array| array << e.jsonize }.to_json
        @event = @room.events
        format.js { render :layout => false }
      else
        @Jevents = @room.reload.events.reload.all.each_with_object([]) {|e, array| array << e.jsonize }.to_json
        @event = @room.events
        format.js { render :layout => false }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.json { head :no_content }
    end
  end
end
