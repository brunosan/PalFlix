# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user, :class=> User do |u|
  u.name                  "Bruno Sánchez-Andrade Nuño"
  u.email                 "brunosan@gmail.com"
  u.password              "foobar"
  u.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :movie, :class => Movie do |m|
  m.title                 "Rocky 0"
  m.link                  "#"
end

Factory.sequence :title do |n|
  "Rocky #{n}"
end

Factory.define :rating, :class => Rating do |r|
  r.grade 5
  r.movie {|m| m.association :movie}
  r.user {|u| m.association :user}
end

