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

    total_users=User.count
    for u in 1..total_users do
      user=User.find(u)
      total_movies=Movie.count
      for m in 1..total_movies do
        user.ratings.create!(:grade => rand(10), :movie_id =>m) if rand(3) == 1
      end
    end


  end
end

