class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.decimal :cost, :precision => 8, :scale => 2, :default => 0.0
      t.integer :project_id
      t.integer :phase_id
      t.integer :user_id
      t.integer :task_type_id
      t.integer :task_status_id

      t.timestamps
    end
    
    add_index :tasks, :name
  end

  def self.down
    drop_table :tasks
  end
end
