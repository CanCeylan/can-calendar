class Event < ActiveRecord::Base
  attr_accessible :end_date, :name, :price, :start_date, :color, :room_id
  validate :testValidation
  belongs_to :room

  def testValidation
    !Event.where("id != ? AND room_id == ? AND
                    ((start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?) OR (start_date > ? AND end_date < ?))",
                    self.id,
                    self.room_id,
                    self.start_date,
                    self.start_date,
                    self.end_date,
                    self.end_date,
                    self.start_date,
                    self.end_date).blank? ?
        errors.add(:name, "Scuza ma ci sono problema in qui") : return
  end


  def jsonize
    {id: self.id, title: self.name, start: self.start_date.strftime('%a %b %d %Y'), end: self.end_date.strftime('%a %b %d %Y'), price: self.price, backgroundColor: self.color}
  end

end
