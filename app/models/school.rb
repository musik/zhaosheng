class School < ActiveRecord::Base
  attr_accessible :address, :address_fetched, :code, :name, :phone, :postal,:gongban
  has_many :majors
end
