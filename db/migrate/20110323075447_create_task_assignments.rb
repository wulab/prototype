class CreateTaskAssignments < ActiveRecord::Migration
  def self.up
    create_table :task_assignments do |t|
      t.integer :task_id
      t.integer :user_id

      t.timestamps
    end
    
    add_index :task_assignments, :task_id
    add_index :task_assignments, :user_id
    add_index :task_assignments, [:task_id, :user_id], :unique => true
  end

  def self.down
    drop_table :task_assignments
  end
end
