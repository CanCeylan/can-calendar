class Room < ActiveRecord::Base
  attr_accessible :rType, :events_attributes
  has_many :events, :dependent => :destroy
  accepts_nested_attributes_for :events
end
