class CreateTaskTypes < ActiveRecord::Migration
  def self.up
    create_table :task_types do |t|
      t.string :name
    end
    
    # Add default types
    unless TaskType.first
      TaskType.create!(:name => 'normal')
      TaskType.create!(:name => 'purchase')
    end
  end

  def self.down
    drop_table :task_types
  end
end
