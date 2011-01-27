class Movie < ActiveRecord::Base

  has_many :ratings, :dependent => :destroy
  has_many :users, :through => :ratings

  default_scope :order => 'movies.title ASC'

  validates :title, :presence => true,
                    :length   => { :within => 1..50},
                    :uniqueness => { :case_sensitive => false }

  attr_accessible :title
  has_many :comments, :dependent => :destroy


  cattr_reader :per_page
  @@per_page = 10

end
