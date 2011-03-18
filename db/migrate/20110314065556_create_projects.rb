class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.date :due_date
      t.decimal :budget, :precision => 10, :scale => 2, :default => 0.0

      t.timestamps
    end
    
    add_index :projects, :name, :unique => true
  end

  def self.down
    drop_table :projects
  end
end
