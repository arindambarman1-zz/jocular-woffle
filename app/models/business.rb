class Business < ActiveRecord::Base
  has_one :checkin
  has_one :city
end
