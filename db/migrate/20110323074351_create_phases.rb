class CreatePhases < ActiveRecord::Migration
  def self.up
    create_table :phases do |t|
      t.string :name
      t.text :description
      t.datetime :start
      t.datetime :due
      t.datetime :finish
      t.decimal :budget, :precision => 8, :scale => 2, :default => 0.0
      t.integer :project_id

      t.timestamps
    end
    
    add_index :phases, :name
  end

  def self.down
    drop_table :phases
  end
end
