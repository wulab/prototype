Factory.define :user do |user|
  user.name "Factory Girl"
  user.email "factory@girl.com"
  user.password "secret"
  user.password_confirmation "secret"
end

Factory.sequence :email do |n|
  "factory#{n}@girl.com"
end
