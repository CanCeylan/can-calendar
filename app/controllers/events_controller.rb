class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index

    @events = Event.all
    @Jevents = @events.each_with_object([]) {|e, array| array << e.jsonize }.to_json
    @event = Event.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @Jevents }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new(params[:event])

    respond_to do |format|
      format.html {    render :layout => false } # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    if params[:opt] == '1'
      respond_to do |format|
        #format.js { render json: @Jevents.to_json, status: :created, location: @event }
        format.js { render :layout => false}
      end
    end
  end

  # POST /events
  # POST /events.json
  def create
    startD = params[:event][:start_date]
    endD =  params[:event][:end_date]
    name = params[:event][:name]
    price = params[:event][:price]
    color = params[:event][:color]
    @eType = params[:eType]
    room = Room.find(params[:event][:room_id])

    update_events(startD, endD, name, price, color, room)
    @Jevents = room.events.all.each_with_object([]) {|e, array| array << e.jsonize }.to_json

    respond_to do |format|
      #format.js { render json: @Jevents.to_json, status: :created, location: @event }
      format.js { render :layout => false}
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    startD = params[:event][:start_date]
    endD = params[:event][:end_date]
    name = params[:event][:name]
    price = params[:event][:price]
    color = params[:event][:color]
    room = Room.find(params[:event][:room_id])

    if (endD.to_date - startD.to_date).to_i == 0
      respond_to do |format|
        if @event.update_attributes(params[:event])
          @data = @event.jsonize.to_json
          @eType = params[:eType]
          format.js { render :layout => false }
        else
          format.html { render action: "edit" }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    else
      update_events(startD, endD, name, price, color, room)
      @Jevents = room.events.all.each_with_object([]) {|e, array| array << e.jsonize }.to_json
      @eType = 'expand'
      respond_to do |format|
        format.js { render :layout => false}
      end

    end


  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.js { render :layout => false }
    end
  end
  private

  def update_events(startD, endD, name, price, color, room)
    startD.to_date.upto(endD.to_date) do |d|
      event = room.events.find_or_initialize_by_start_date(d)
      event.update_attributes(:start_date => d, :end_date => d, :name => name, :price => price, :color => color)
      event.save
    end
  end

end
