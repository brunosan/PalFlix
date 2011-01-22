# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Bruno Sánchez-Andrade Nuño"
  user.email                 "brunosan@gmail.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :movie do |movie|
  movie.title                 "Rocky 0"
  movie.link                  "#"
end

Factory.sequence :title do |n|
  "Rocky #{n}"
end


