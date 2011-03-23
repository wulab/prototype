# == Schema Information
# Schema version: 20110323080303
#
# Table name: tasks
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  description    :text
#  cost           :decimal(, )
#  project_id     :integer
#  phase_id       :integer
#  user_id        :integer
#  task_type_id   :integer
#  task_status_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Task < ActiveRecord::Base
  attr_accessible :name, :description, :cost, :task_type, :task_status
  
  belongs_to :project
  belongs_to :user
  belongs_to :phase
  belongs_to :task_type
  belongs_to :task_status
  
  validates :project, :task_type, :task_status, :presence => true
  validates :name, :presence => true,
                   :length => {:maximum => 150}
  validates :description, :presence => true
  validates :cost, :presence => true,
                   :numericality => {:greater_than_or_equal_to => 0, :less_than => 10**6}
  
end
