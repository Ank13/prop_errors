class DateValidator < ActiveModel::Validator
  def validate(event)
    unless event.date > Date.today
      event.errors[:date] << 'event must take place in the future'
    end
  end
end
 

class Event < ActiveRecord::Base
  include ActiveModel::Validations
  validates :date, :presence => true 
  validates :title, :presence => true, :uniqueness =>true
  validates :organizer_email, :presence => true, :format => { :with => /.+@.+\..+/,
    :message => "must have a valid format"}
  validates :organizer_name, :presence => true
  validates_with DateValidator
end


