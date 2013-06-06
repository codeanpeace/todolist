class CreateTask < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
      t.string :task
      t.string :details
      t.boolean :completed, :default => false
    end
  end

  def down
    drop_table :tasks
  end
end
