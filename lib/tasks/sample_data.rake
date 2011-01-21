require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin=User.create!(:name => "John developer",
                 :email => "brunosan@gmail.com",
                 :password => "1234.",
                 :password_confirmation => "1234.")
    admin.toggle!(:admin)
    15.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@brunosan.eu"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end

