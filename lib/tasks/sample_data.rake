require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin=User.create!(:name => "Adam Admin",
                 :email => "admin@gmail.com",
                 :password => "1234.",
                 :password_confirmation => "1234.")
    admin.toggle!(:admin)
    noadmin=User.create!(:name => "User Uni",
                 :email => "user@gmail.com",
                 :password => "1234.",
                 :password_confirmation => "1234.")
    15.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@brunosan.eu"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end

    Movie.create!(:title => "E.T.",
                 :link => "#")
    15.times do |n|
      title = Faker::Company.bs
      Movie.create!(:title => title,
                    :link => 'x')

    end

    50.times do
      total_users=User.count
      user=User.find(rand(total_users))
      total_movies=Movie.count
      20.times do
        user.ratings.create(:grade => rand(10), :movie_id =>rand(total_movies))
      end
    end

    #Movie.all(:limit => 5).each do |movie|
    #  total_users=User.count
    #  20.times do
    #    movie.ratings.create(:grade => rand(10), :user_id =>rand(total_users))
    #  end
    #end

  end
end

