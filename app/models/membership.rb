# == Schema Information
# Schema version: 20110319173807
#
# Table name: memberships
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Membership < ActiveRecord::Base
  attr_accessible :user_id
  
  belongs_to :project
  belongs_to :user
  
  validates :project_id, :presence => true
  validates :user_id, :presence => true
end
