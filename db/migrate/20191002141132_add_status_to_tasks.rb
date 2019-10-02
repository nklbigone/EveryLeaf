class AddStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :start_at, :date
    add_column :tasks, :end_at, :date
  end
end
