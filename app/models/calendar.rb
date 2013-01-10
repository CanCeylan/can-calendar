class Calendar < ActiveRecord::Base
  attr_accessible :end_date, :resource_id, :start_date, :title
  has_one :resource



  #validates :start_date, :uniqueness => { :scope => :resource_id }
  #validates :end_date, :uniqueness => { :scope => :resource_id }
  validate :testValidation

  def testValidation
    !Calendar.where("id != ? AND
                    resource_id = ? AND
                    ((start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?) OR (start_date > ? AND end_date < ?))",
                      self.id,
                      self.resource_id,
                      self.start_date,
                      self.start_date,
                      self.end_date,
                      self.end_date,
                      self.start_date,
                      self.end_date).blank? ?
    errors.add(:name, "cannot contain the characters !@#%*()_-+=") : return
  end

  #def testValidation
  #  Calendar.find_all_by_resource_id(self.resource_id).each do |c|
  #    if (self.start_date >= c.start_date && self.start_date <= c.end_date)
  #
  #    end
  #  end
  #end

  def jsonize
    {id: self.id, title: self.title, start: self.start_date.strftime('%a %b %d %Y'), end: self.end_date.strftime('%a %b %d %Y'), resource: self.resource_id}
  end



end
