class Movie < ActiveRecord::Base

  default_scope :order => 'movies.created_at DESC'

  validates :title, :presence => true,
                    :length   => { :within => 1..50},
                    :uniqueness => { :case_sensitive => false }

  attr_accessible :title
  has_many :comments, :dependent => :destroy


  cattr_reader :per_page
  @@per_page = 10

end
