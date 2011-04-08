# == Schema Information
# Schema version: 20110323080303
#
# Table name: task_assignments
#
#  id         :integer         not null, primary key
#  task_id    :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class TaskAssignment < ActiveRecord::Base
end
