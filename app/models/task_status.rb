# == Schema Information
# Schema version: 20110323080303
#
# Table name: task_statuses
#
#  id   :integer         not null, primary key
#  name :string(255)
#

class TaskStatus < ActiveRecord::Base
  has_many :tasks
  
  # Type of statuses
  NEW = 1
  CLOSED = 2
  DUPLICATE = 3
end
