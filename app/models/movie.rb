class Movie < ActiveRecord::Base
  default_scope :order => 'rating DESC'

  validates :title, :presence => true
  validates :pal, :presence => true
  validates :rating, :presence => true, :numericality => true
 
  has_many :comments, :dependent => :destroy
end
