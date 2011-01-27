class Rating < ActiveRecord::Base

  #I had to let all attributes accesible cause I can´t
  #figure out out to then set the movie_id if I call
  #it from user, and otherwise
  #attr_accessible :grade

  belongs_to :user
  belongs_to :movie

  default_scope :order => 'ratings.created_at DESC'

  validates :grade, :inclusion => { :in => 0..9 }


  def to_text
    texto = case self.grade
            when 0..1 then "horrible"
            when 2..3 then "bad"
            when 4..5 then "not bad"
            when 6..7 then "good"
            when 8..9 then "very good"
            when 10 then "master piece"
            end
  end
end
