class Resource < ActiveRecord::Base
  attr_accessible :name
  belongs_to :calendar

  def jsonize
    {name: self.name,
     id: self.id}
  end

end
