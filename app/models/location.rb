class Location < ActiveRecord::Base
  attr_accessible :name
  has_many :stops
end
