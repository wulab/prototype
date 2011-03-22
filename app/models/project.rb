# == Schema Information
# Schema version: 20110314065556
#
# Table name: projects
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  start_date  :date
#  end_date    :date
#  due_date    :date
#  budget      :decimal(10, 2)  default(0.0)
#  created_at  :datetime
#  updated_at  :datetime
#

class Project < ActiveRecord::Base
  attr_accessible :name, :description, :start_date, :end_date, :due_date, :budget
  
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  
  validates :name, :presence => true,
                   :length => {:maximum => 100},
                   :uniqueness => {:case_sensitive => false}
  validates :description, :presence => true
  validates :budget, :presence => true,
                     :numericality => {:greater_than_or_equal_to => 0}
  
  def has_user?(user)
    memberships.find_by_user_id(user)
  end
  
  def add_user!(user)
    memberships.create!(:user_id => user.id)
  end
  
  def remove_user!(user)
    memberships.find_by_user_id(user).destroy
  end
  
end
