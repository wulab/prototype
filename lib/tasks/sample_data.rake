require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(
      :name => "Administrator",
      :email => "admin@wu.ac.th",
      :password => "qwerty",
      :password_confirmation => "qwerty"
    )
    admin.toggle!(:admin)
    webmaster = User.create!(
      :name => "Webmaster",
      :email => "webmaster@wu.ac.th",
      :password => "qwerty",
      :password_confirmation => "qwerty"
    )
    webmaster.toggle!(:admin)
    98.times do |n|
      name = Faker::Name.name
      email = "#{name.scan(/\w/).join.downcase}@wu.ac.th"
      password = "qwerty"
      User.create!(
        :name => name,
        :email => email,
        :password => password,
        :password_confirmation => password
      )
    end
    
  end
end
