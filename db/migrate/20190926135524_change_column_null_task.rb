class ChangeColumnNullTask < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :title, :string, null:false
    change_column :tasks, :task_name, :string, null:false
  end
end
