class Comment < ActiveRecord::Base
  belongs_to :movie

  validates :commenter, :presence => true
end
