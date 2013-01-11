class Event < ActiveRecord::Base
  attr_accessible :end_date, :name, :price, :start_date, :color, :room_id
  validate :testValidation
  belongs_to :room
  before_save :divideEvent, :on => [:create, :update]

  def testValidation
    if !Event.where("id != ? AND room_id == ? AND
                    ((start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?) OR (start_date > ? AND end_date < ?))",
                    self.id,
                    self.room_id,
                    self.start_date,
                    self.start_date,
                    self.end_date,
                    self.end_date,
                    self.start_date,
                    self.end_date).blank?
        errors.add(:name, "Scuza ma ci sono problema in qui")
    else
      true
    end
  end


  def jsonize
    {id: self.id, title: self.name, start: self.start_date.strftime('%a %b %d %Y'), end: self.end_date.strftime('%a %b %d %Y'), price: self.price, backgroundColor: self.color}
  end

  def divideEvent
    if (self.start_date.to_date != self.end_date.to_date)
      if self.new_record?
        (self.start_date.to_date + 1.day).upto(self.end_date.to_date) do |d|
          event = self.room.events.find_or_initialize_by_start_date(d)
          event.update_attributes(:start_date => d, :end_date => d, :name => name, :price => price, :color => color)
        end
        self.end_date = self.start_date
      else
        (self.start_date.to_date + 1.day).upto(self.end_date.to_date) do |d|
          event = self.room.events.find_or_initialize_by_start_date(d)
          event.room.events.create(:start_date => d, :end_date => d, :name => self.name, :price => self.price, :color => self.color)
        end
        self.end_date = self.start_date
      end

    end
  end

end
