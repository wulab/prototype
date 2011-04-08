# == Schema Information
# Schema version: 20110323080303
#
# Table name: task_types
#
#  id   :integer         not null, primary key
#  name :string(255)
#

class TaskType < ActiveRecord::Base
  has_many :tasks

  # Type of tasks
  NORMAL = 1
  PURCHASE = 2
end
