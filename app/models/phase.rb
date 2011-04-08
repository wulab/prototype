# == Schema Information
# Schema version: 20110323080303
#
# Table name: phases
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  start       :datetime
#  due         :datetime
#  finish      :datetime
#  budget      :decimal(8, 2)   default(0.0)
#  project_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Phase < ActiveRecord::Base
  attr_accessible :name, :description, :start, :due, :finish, :budget
  
  belongs_to :project
  has_many :tasks
  
  validates :name, :presence => true,
                   :length => {:maximum => 100}
  validates :due, :project, :presence => true
  validates :budget, :presence => true,
                     :numericality => {:greater_than_or_equal_to => 0, :less_than => 10**8}
  
end
