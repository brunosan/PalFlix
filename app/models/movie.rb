class Movie < ActiveRecord::Base

  validates :title, :presence => true
  validates :pal, :presence => true
  validates :rating, :presence => true, :numericality => true
 
  has_many :comments, :dependent => :destroy
end
