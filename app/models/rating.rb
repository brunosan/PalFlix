class Rating < ActiveRecord::Base

  #attr_accessible :grade

  belongs_to :user
  belongs_to :movie

  default_scope :order => 'ratings.created_at DESC'

  validates :grade, :inclusion => { :in => 0..9 }

end
