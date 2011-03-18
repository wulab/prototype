Factory.define :user do |user|
  user.name "Factory Girl"
  user.email "factory@girl.com"
  user.password "secret"
  user.password_confirmation "secret"
end

Factory.sequence :email do |n|
  "factory#{n}@girl.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Lorem ipsum dolor sit amet"
  micropost.association :user
end

Factory.define :project do |project|
  project.name "Et eos est ipsum aut vitae"
  project.description "Aut incidunt id aut eum recusandae doloribus"
  project.budget 99.99
end

Factory.sequence :project_name do |n|
  "Factory project #{n}"
end
