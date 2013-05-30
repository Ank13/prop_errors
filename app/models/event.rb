class Event < ActiveRecord::Base
  validates :date, :presence => true
  validates :title, :presence => true, :uniqueness =>true
  validates :organizer_email, :presence => true, :format => { :with => /.+@.+\..+/,
    :message => "must have a valid format"}
  validates :organizer_name, :presence => true
end
