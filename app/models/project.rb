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
  
  validates :name, :presence => true,
                   :length => {:maximum => 100},
                   :uniqueness => {:case_sensitive => false}
  validates :description, :presence => true
  validates :budget, :presence => true,
                     :numericality => {:greater_than_or_equal_to => 0, :less_than => 10**8}
  
  default_scope :order => "projects.created_at DESC"
end
