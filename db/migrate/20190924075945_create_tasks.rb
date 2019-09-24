class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string   :title
      t.string   :task_name
      t.integer  :user_id
      t.timestamps
    end
  end
end
