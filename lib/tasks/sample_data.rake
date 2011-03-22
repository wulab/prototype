require 'faker'   

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_projects
    make_memberships
  end
end

def make_users
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
  50.times do |n|
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

def make_microposts
  User.all(:limit => 6).each do |user|
    50.times do
      user.microposts.create!(:content => Faker::Lorem.sentence(5))
    end
  end
end

def make_projects
  10.times do |n|
    name = Faker::Company.catch_phrase
    description = Faker::Lorem.paragraphs.join("\n\n")
    budget = (rand * 10**6).to_i
    start_date = rand(365).day.ago
    end_date = rand(365).day.from_now
    due_date = rand(365).day.from_now
    Project.create!(
      :name => name,
      :description => description,
      :budget => budget,
      :start_date => start_date,
      :end_date => end_date,
      :due_date => due_date
    )
  end
end

def make_memberships
  users = User.all(:limit => 6)
  projects = Project.all
  projects.each do |project|
    users.each {|user| project.add_user!(user) }
  end
end
