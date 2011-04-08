require 'faker'   

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_projects
    make_memberships
    insert_default_task_types
    insert_default_task_statuses
    make_project_tasks
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
    Project.create!(
      :name => name,
      :description => description,
      :budget => budget,
    )
  end
end

def make_memberships
  users = User.all(:limit => 5)
  projects = Project.all
  projects.each do |project|
    users.each {|user| project.add_user!(user) }
  end
end

def insert_default_task_types
  unless TaskType.first
    TaskType.create!(:name => 'normal')
    TaskType.create!(:name => 'purchase')
  end
end

def insert_default_task_statuses
  unless TaskStatus.all.any?
    TaskStatus.create!(:name => 'open')
    TaskStatus.create!(:name => 'closed')
    TaskStatus.create!(:name => 'duplicate')
  end
end

def make_project_tasks
  projects = Project.all
  task_types = TaskType.all
  task_statuses = TaskStatus.all
  projects.each do |project|
    10.times do |n|
      project.tasks.create!(
        :name => Faker::Company.bs.humanize,
        :description => Faker::Lorem.sentences.join(" "),
        :cost => (rand(3) == 0) ? rand(33)/100.0 * project.budget : 0.0,
        :task_type_id => task_types.shuffle[0].id,
        :task_status_id => task_statuses.shuffle[0].id
      )
    end
  end
end
