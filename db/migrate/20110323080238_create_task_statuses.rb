class CreateTaskStatuses < ActiveRecord::Migration
  def self.up
    create_table :task_statuses do |t|
      t.string :name
    end
    
    # Add default statuses
    unless TaskStatus.all.any?
      TaskStatus.create!(:id => 1, :name => 'open')
      TaskStatus.create!(:id => 2, :name => 'closed')
      TaskStatus.create!(:id => 3, :name => 'duplicate')
    end
  end

  def self.down
    drop_table :task_statuses
  end
end
