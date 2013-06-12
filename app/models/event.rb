class DateValidator < ActiveModel::Validator
  
  def validate(event)
    date_is_present(event)
    date_is_valid(event)
    date_is_in_future(event)
  end
  
  def date_is_present(event)
    if event.date.nil?
      event.errors[:date] << 'must be entered.'
    end
  end
  
  def date_is_valid(event)
    begin
      event.date && Date.parse(event.date.to_s)
    rescue
      event.errors[:date] << "doesn't seem to be a valid date."
    end
  end
  
  def date_is_in_future(event)
    if event.date && event.date < Date.today
      event.errors[:date] << "must take place in the future."
    end
  end
  
end
 
class Event < ActiveRecord::Base
  include ActiveModel::Validations
  validates :title, :presence => true, :uniqueness =>true
  validates :organizer_email, :presence => true, :format => { :with => /.+@.+\..+/,
    :message => "must have a valid format"}
  validates :organizer_name, :presence => true
  validates_with DateValidator
end
